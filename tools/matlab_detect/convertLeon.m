clear;
clc;

load('temp.mat');
positiveInstances(1) = [];
positiveInstances(368) = [];    % delete outbound picture

INST_SIZE = 708;

for i = 1:size(positiveInstances,2)
    if(i <= INST_SIZE)
        positiveInstances(i).imageFilename = strrep(...
            positiveInstances(i).imageFilename, ...
            'E:\Drive\½Òµ{\Data_Mining\Whale_Mining\ROI\', ...
            '/Volumes/Transcend/kaggle/imgs/new_imgs/');
    else
        positiveInstances(INST_SIZE + 1) = [];
    end
end

positiveInstances(372).objectBoundingBoxes = [1005,1,801,934];      % refine outbound picture
positiveInstances(385).objectBoundingBoxes = [1431,1,1278,1482];    % refine outbound picture

save(['positiveInstances_', num2str(INST_SIZE), '.mat'], 'positiveInstances');
