`clc;
clear;
%%% BE SURE TO CHANGE THE FILE NAME %%%
detector = vision.CascadeObjectDetector('detectorFile_stages11_pics708_alarm0.075.xml');

%% Test all test samples
d = dir('imgs/new_imgs/');
load('temp.mat');
OutputPositiveInstances = positiveInstances;

for i = 6:size(d)
    
    img = imread(['imgs/new_imgs/', d(i).name]);
    bbox = step(detector,img);
    
    if(size(bbox,1) == 0)
        OutputPositiveInstances(i-5).imageFilename = ...
                ['/Volumes/Transcend/kaggle/imgs/new_imgs/' ,d(i).name];
        OutputPositiveInstances(i-5).objectBoundingBoxes = [];
        fprintf(['reading ', num2str(i-5), ' th imgs/new_imgs/', d(i).name, ', bbox = []\n'])
    else
        for j = 1:size(bbox,1)
            OutputPositiveInstances(i-5).imageFilename = ...
                ['/Volumes/Transcend/kaggle/imgs/new_imgs/' ,d(i).name];
            OutputPositiveInstances(i-5).objectBoundingBoxes = bbox(j, :);

            fprintf(['reading ', num2str(i-5), ' th imgs/new_imgs/', d(i).name, ', bbox = ', num2str(bbox(j, :)), '\n'])
        end
    end
    save('OutputPositiveInstances.mat', 'OutputPositiveInstances');
    
    % detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'right whale');
end

%% Test with single samples

% img = imread('imgs/new_imgs/w_7.jpg');
% bbox = step(detector,img);
% detectedImg = insertObjectAnnotation(img,'rectangle', bbox, 'right whale');
% 
% % show image
% 
% figure;
% imshow(detectedImg);