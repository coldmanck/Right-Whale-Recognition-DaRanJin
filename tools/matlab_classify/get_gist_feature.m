function image_feats = get_gist_feature(image_paths)

N = size(image_paths , 1);

% GIST feature is a 512 x 1 vector , so we make image_feats in Nx512
image_feats = zeros(N , 512);

% Follow the sample code from : http://people.csail.mit.edu/torralba/code/spatialenvelope/
% GIST parameter
clear param
param.imageSize = [256 256]; % it works also with non-square images (use the most common aspect ratio in your set)
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale
param.numberBlocks = 4;
param.fc_prefilt = 4;

for i = 1 : N
    imgPath = image_paths(i);
    imgCurrentRead = imread(char(imgPath));
    
    GIST = LMgist(imgCurrentRead , '' , param);
    image_feats(i , :) = GIST;
end

end




