%% Reachability analysis of the closedLoop system of AcasXu with Dubins model
% There are 2 main components required:
% - Plant model
% - AcasXu networks x5 (choose based on t=0 and previous advisory)
clc;clear;close all;
%% Load components

% Plant dynamics
reachStep = 0.05;
controlPeriod = 1;
outputMat = eye(9);
outputMat = outputMat(7:9,:);
plant = NonLinearODE(9,1,@dynamics2D_dt_eps_new,reachStep,controlPeriod,outputMat);

% Controllers
acasxu11 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_1_1_batch_2000.mat');
acasxu21 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_2_1_batch_2000.mat');
acasxu31 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_3_1_batch_2000.mat');
acasxu41 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_4_1_batch_2000.mat');
acasxu51 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_5_1_batch_2000.mat');
acasxuNNs.n11 = acasxu11;
acasxuNNs.n21 = acasxu21;
acasxuNNs.n31 = acasxu31;
acasxuNNs.n41 = acasxu41;
acasxuNNs.n51 = acasxu51;
% Other components
scale_mean = [19791.0910000000,0,0,650,600];
scale_range = [60261,6.28318530718000,6.28318530718000,1100,1200];
Unn45 = Star([0.142727;0.142727],[0.142727;0.142727]);

%% Setup verification scenario
% Experiment 1
% Ownship
x1 = 25000; x2 = 10234; x3 = 0.3;
% Intruder
x4 = 10030; x5 = 3450; x6 = 0.7;
% "Environment"
[x7, x8, x9] = environment([x1 x2 x3],[x4 x5 x6]);
% Initial state set
initial_state = [x1;x2;x3;x4;x5;x6;x7;x8;x9];
[lb,ub] = calc_unc(initial_state,10);
init_set = Star(lb,ub);
% Input set (COC)
Up = Star(0,0);
minIdx = 1;

%% Reachability analysis (Multiple steps)
tf = 15; % Final time (seconds)
times = 0:controlPeriod:tf+controlPeriod;
allReach = [];
acasout = cell(1,length(times));
for k=times(1:end-1)
    disp(' ');
    disp('***************************************');
    disp('Step ' + string(k));
    % First reachability step
    init_set =  plant.stepReachStar(init_set,Up);
    allReach = [allReach init_set];
    % Output set
    Ro = init_set.affineMap(outputMat,[]);
    % Normalize inputs
    Unn = Ro.affineMap(eye(3),-1*scale_mean(1:3)');
    Unn = Unn.affineMap(diag(1./scale_range(1:3)),[]);
    Unn = Unn.concatenate(Unn45);
    % Compute NN outputs
    yNN = reachAcasXu(minIdx,Unn,acasxuNNs);
    acasout{int64(k*5+1)}= yNN;
    % Compute advisory command
    minIdx = getMinIndexes(yNN);
    Uown = advisoryACAS(minIdx);
    Up = Star(Uown,Uown);
    % End cycle
end

%% Plot results
% Plot trajectories
f1 = figure;
Star.plotBoxes_2D(allReach(1),1,2,'r');
hold on;
Star.plotBoxes_2D(allReach(1),4,5,'b');
Star.plotBoxes_2D_noFill(plant.intermediate_reachSet,1,2,'r');
Star.plotBoxes_2D_noFill(plant.intermediate_reachSet,4,5,'b');
grid;
xlabel('X Position (ft)');
ylabel('Y position (ft)');
legend('Ownship','Intruder')

% Plot distance
times = 0:reachStep:tf+reachStep;
pdSet = [];
timeSet = [];
distSet = [];
for i=1:length(times)-1
    X = Star(times(i),times(i)+1);
    timeSet= [timeSet X];
    Y = plant.intermediate_reachSet(i).affineMap([0 0 0 0 0 0 1 0 0],[]);
    distSet = [distSet Y];
    pdSet = [pdSet X.concatenate(Y)];
end
f2 = figure;
Star.plotBoxes_2D(pdSet,1,2,'r')
ylabel('Distance (ft)');
xlabel('Time (s)');
% title('Distance to intruder');

if ~exist('../data_reach','dir')
    mkdir('../data_reach')
end

saveas(f1,'../data_reach/exp1_trajectories','png');
saveas(f2,'../data_reach/exp1_distance','png');
save('../data_reach/exp1reach.mat', 'allReach','lb','ub');



%% Helper functions
% Get min index for AcasXu networks (advisory command)
function idxs = getMinIndexes(star_set)
    if length(star_set) > 1
        X = Star.merge_stars(star_set,1,'parallel');
    else
        X = star_set;
    end
    [mm,MM] = X.getRanges;
    [~, idx1] = min(mm);
    idxs = [];
    for i=1:length(mm)
        if mm(i) <= MM(idx1)
            idxs = [idxs i];
        end
    end
end
% Set advisory to ownship
function y = advisoryACAS(r)
    if r == 1
        y = 0;
    elseif r == 2
        y = deg2rad(1.5);
    elseif r == 3
        y = deg2rad(-1.5);
    elseif r == 4
        y = deg2rad(3.0);
    elseif r == 5
        y = deg2rad(-3.0);
    end
end
% Choose NN to execute
function y = reachAcasXu(advise,Unn,acasNNs)
    if advise == 1
        y = acasNNs.n11.reach(Unn,'exact-star');
    elseif advise == 2
        y = acasNNs.n21.reach(Unn,'exact-star');
    elseif advise == 3
        y = acasNNs.n31.reach(Unn,'exact-star');
    elseif advise == 4
        y = acasNNs.n41.reach(Unn,'exact-star');
    elseif advise == 5
        y = acasNNs.n51.reach(Unn,'exact-star');
    end
end