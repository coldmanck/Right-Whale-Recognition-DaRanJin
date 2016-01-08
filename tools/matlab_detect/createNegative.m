formatStr = 'neg%d.jpg';   % Output format for negatives

if ~exist('imgs_neg', 'dir')
    mkdir('imgs_neg');
end

d = dir('imgs/*');
for j = 4:size(d, 1)
    path = d(j,:).name;
    images = imageSet(fullfile('imgs', path));  % 'imgs': Folder of images
    for i = 1:images.Count
        imginp = read(images,i);  % Read an image
        imcropped = imcrop(imginp,[1 1 1078 670]); % Crop
        fileName = sprintf(formatStr,i);
        
        save_path = ['imgs_neg', '/', path];
        if ~exist(save_path, 'dir')
            mkdir(save_path);
        end
        imwrite(imcropped, [save_path, '/', fileName]); % Save negative images
    end
end