%% Run multiple scenarios using NNV reachability analysis
clc;clear;close all;
% --- Setup scenarios ---
% 1)
lb1 = [10000; 5234; 0.2; 10030; 3450; 0.7; 17783; -1.7540; 0.4900];
up1 = [10006; 5240; 0.21; 10036; 3456; 0.71; 17902; -1.7674; 0.5100];
init_set1 = Star(lb1,up1);
% 2)
lb2 = [10000; 5234; 0.2; 10030; 3450; 0.7; 17783; -1.7574; 0.5];
up2 = [10006; 5240; 0.2; 10036; 3456; 0.7; 17902;-1.7540; 0.5];
init_set2 = Star(lb2,up2);
% 3)
lb3 = [10000; 5234; 0.2; 10030; 3450; 0.7; 17823; -1.7551; 0.5];
up3 = [10002; 5236; 0.2; 10032; 3452; 0.7; 17862; -1.7528; 0.5];
init_set3 = Star(lb2,up2);
% Number of simulations
init_set = [init_set1 init_set2 init_set3];
m = size(init_set,2);
%% Simulate all
sets1 = cell(1,m);
timing = cell(1,m);
parfor i=3:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    AllSets{i} = SetSimulationNNCS(init_set(i),1,3,'approx-star');
    timing{i} = toc(t);
    disp(' ');
end