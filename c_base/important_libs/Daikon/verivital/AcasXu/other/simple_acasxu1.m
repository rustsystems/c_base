%% Convert acasxu networks to a one large network
% By assuming that time (vertical separation) is always 0, we can convert
% the AcasXu system into a single NN

% Controllers
acasxu11 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_1_1_batch_2000.mat');
acasxu21 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_2_1_batch_2000.mat');
acasxu31 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_3_1_batch_2000.mat');
acasxu41 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_4_1_batch_2000.mat');
acasxu51 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_5_1_batch_2000.mat');

% Create big net (acasxu_big_1)
net = feedforwardnet([250 250 250 250 250 250]);
m = length(net.layers);
net.inputs{1}.processFcns = {};
net.outputs{m}.processFcns = {};
net.inputs{1}.size = 5;
net.layers{m}.size = 25;

% Add activation functions to net layers
for i=1:m
    net.layers{i}.transferFcn = 'poslin';
end
net.layers{m}.transferFcn = 'purelin';

% First Layer
net.IW{1}(1:50,:) = acasxu11.Layers(1).W;
net.IW{1}(51:100,:) = acasxu21.Layers(1).W;
net.IW{1}(101:150,:) = acasxu31.Layers(1).W;
net.IW{1}(151:200,:) = acasxu41.Layers(1).W;
net.IW{1}(201:250,:) = acasxu51.Layers(1).W;
net.b{1}(1:50) = acasxu11.Layers(1).b;
net.b{1}(51:100) = acasxu21.Layers(1).b;
net.b{1}(101:150) = acasxu31.Layers(1).b;
net.b{1}(151:200) = acasxu41.Layers(1).b;
net.b{1}(201:250) = acasxu51.Layers(1).b;

% Second layer
net.LW{2,1} = zeros(250,250);
net.LW{2,1}(1:50,1:50) = acasxu11.Layers(2).W;
net.LW{2,1}(51:100,51:100) = acasxu21.Layers(2).W;
net.LW{2,1}(101:150,101:150) = acasxu31.Layers(2).W;
net.LW{2,1}(151:200,151:200) = acasxu41.Layers(2).W;
net.LW{2,1}(201:250,201:250) = acasxu51.Layers(2).W;
net.b{2}(1:50) = acasxu11.Layers(2).b;
net.b{2}(51:100) = acasxu21.Layers(2).b;
net.b{2}(101:150) = acasxu31.Layers(2).b;
net.b{2}(151:200) = acasxu41.Layers(2).b;
net.b{2}(201:250) = acasxu51.Layers(2).b;

% Third Layer
net.LW{3,2} = zeros(250,250);
net.LW{3,2}(1:50,1:50) = acasxu11.Layers(3).W;
net.LW{3,2}(51:100,51:100) = acasxu21.Layers(3).W;
net.LW{3,2}(101:150,101:150) = acasxu31.Layers(3).W;
net.LW{3,2}(151:200,151:200) = acasxu41.Layers(3).W;
net.LW{3,2}(201:250,201:250) = acasxu51.Layers(3).W;
net.b{3}(1:50) = acasxu11.Layers(3).b;
net.b{3}(51:100) = acasxu21.Layers(3).b;
net.b{3}(101:150) = acasxu31.Layers(3).b;
net.b{3}(151:200) = acasxu41.Layers(3).b;
net.b{3}(201:250) = acasxu51.Layers(3).b;


% Fourth Layer
net.LW{4,3} = zeros(250,250);
net.LW{4,3}(1:50,1:50) = acasxu11.Layers(4).W;
net.LW{4,3}(51:100,51:100) = acasxu21.Layers(4).W;
net.LW{4,3}(101:150,101:150) = acasxu31.Layers(4).W;
net.LW{4,3}(151:200,151:200) = acasxu41.Layers(4).W;
net.LW{4,3}(201:250,201:250) = acasxu51.Layers(4).W;
net.b{4}(1:50) = acasxu11.Layers(4).b;
net.b{4}(51:100) = acasxu21.Layers(4).b;
net.b{4}(101:150) = acasxu31.Layers(4).b;
net.b{4}(151:200) = acasxu41.Layers(4).b;
net.b{4}(201:250) = acasxu51.Layers(4).b;

% Fifth Layer
net.LW{5,4} = zeros(250,250);
net.LW{5,4}(1:50,1:50) = acasxu11.Layers(5).W;
net.LW{5,4}(51:100,51:100) = acasxu21.Layers(5).W;
net.LW{5,4}(101:150,101:150) = acasxu31.Layers(5).W;
net.LW{5,4}(151:200,151:200) = acasxu41.Layers(5).W;
net.LW{5,4}(201:250,201:250) = acasxu51.Layers(5).W;
net.b{5}(1:50) = acasxu11.Layers(5).b;
net.b{5}(51:100) = acasxu21.Layers(5).b;
net.b{5}(101:150) = acasxu31.Layers(5).b;
net.b{5}(151:200) = acasxu41.Layers(5).b;
net.b{5}(201:250) = acasxu51.Layers(5).b;

% Sixth Layer
net.LW{6,5} = zeros(250,250);
net.LW{6,5}(1:50,1:50) = acasxu11.Layers(6).W;
net.LW{6,5}(51:100,51:100) = acasxu21.Layers(6).W;
net.LW{6,5}(101:150,101:150) = acasxu31.Layers(6).W;
net.LW{6,5}(151:200,151:200) = acasxu41.Layers(6).W;
net.LW{6,5}(201:250,201:250) = acasxu51.Layers(6).W;
net.b{6}(1:50) = acasxu11.Layers(6).b;
net.b{6}(51:100) = acasxu21.Layers(6).b;
net.b{6}(101:150) = acasxu31.Layers(6).b;
net.b{6}(151:200) = acasxu41.Layers(6).b;
net.b{6}(201:250) = acasxu51.Layers(6).b;

% Output Layer
net.LW{7,6} = zeros(25,250);
net.LW{7,6}(1:5,1:50) = acasxu11.Layers(7).W;
net.LW{7,6}(6:10,51:100) = acasxu21.Layers(7).W;
net.LW{7,6}(11:15,101:150) = acasxu31.Layers(7).W;
net.LW{7,6}(16:20,151:200) = acasxu41.Layers(7).W;
net.LW{7,6}(21:25,201:250) = acasxu51.Layers(7).W;
net.b{7}(1:5) = acasxu11.Layers(7).b;
net.b{7}(6:10) = acasxu21.Layers(7).b;
net.b{7}(11:15) = acasxu31.Layers(7).b;
net.b{7}(16:20) = acasxu41.Layers(7).b;
net.b{7}(21:25) = acasxu51.Layers(7).b;

% This network is like simulating in parallel all the networks
% save('nn_new/simple_acasxu1_net','net');
% net_to_mat('nn_new/simple_acasxu1_net.mat','nn_new/simple_acasxu1.mat');



