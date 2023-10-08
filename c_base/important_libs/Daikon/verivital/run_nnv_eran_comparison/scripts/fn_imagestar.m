% Author: Xiaodong Yang 04/19/2020
function fn_imagestar(images_len, epsilons_len)
    addpath(genpath("../nnv/code/nnv/engine"));
    addpath(genpath("../nnv/code/nnv/tbxmanager"));
    images = csvread('../models/classified_images.csv');
    labels = csvread('../models/classified_Labels.csv')+1;

    numCores = feature('numcores');
    load('../models/cifar_cnn.mat')
    for i = 0:epsilons_len-1
        results.verify = [];
        results.time = [];
        for j = 0:images_len-1
            path = ['../logs/zonotope_inputs',num2str(i),'/','input_',num2str(j)];
            struct = importdata(path,' ',1);
            data = struct.data';
            if size(data,1)==1
                data = [data; zeros(size(data))];
            end

            V = reshape_images(data);

            generator_num = size(V,4)-1;
            C = [eye(generator_num);-eye(generator_num)];
            d = ones(2*generator_num,1);
            pred_lb = -ones(generator_num,1);
            pred_ub = ones(generator_num,1);
            IS = ImageStar(V, C, d, pred_lb, pred_ub);

            t = tic;
            results.verify(end+1) = net.evaluateRobustness(IS, labels(j+1), 'approx-star', numCores);
            results.time(end+1) = toc(t);
        end
        results.total_verified = sum(results.verify);
        results.total_time = sum(results.time);
        path = ['../logs/nnv', num2str(i),'/results.mat'];
        save(path,'results')
    end
end

function data = reshape_images(ori_data)
    temp = reshape(ori_data,[],3,1024);
    temp = reshape(temp, [], 3, 32,32);
    data = permute(uint8(temp),[4,3,2,1]);
end
