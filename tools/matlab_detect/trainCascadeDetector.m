%% Do convertLeon.m first
%% Setting

PICS = 708;
STAGES = 11; % default = 15
alarm = 0.075; % default = 0.01

file_name = ['detectorFile_stages', num2str(STAGES), '_pics', num2str(PICS), ...
    '_alarm', num2str(alarm),'.xml'];
% file_name = 'detectorFile.xml';


%% Training

trainCascadeObjectDetector(file_name, positiveInstances, 'negativeFolder', ...
    'NumCascadeStages', STAGES,'FalseAlarmRate', alarm,'FeatureType','LBP');

WhaleDetectorMdl = vision.CascadeObjectDetector(file_name)