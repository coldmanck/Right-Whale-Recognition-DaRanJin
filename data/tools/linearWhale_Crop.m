
%d = dir('Right-Whale-Recognition-DaRanJin/result/test_box_new/');
load positiveInstances;
d = dir('ImagesTest');
for i = 1:size(positiveInstances, 2)
	box = positiveInstances(i).objectBoundingBoxes;
	%s = strsplit(toCrop(i).imageFilename, '\');
    %try
	hit = 0;
	s = strsplit(positiveInstances(i).imageFilename, '\');
	s = num2str(cell2mat(s(end)));
%	s
	for j = 1:size(d, 1)
		if strcmp(s, d(j).name) == 1
			hit = 1;
			break;
		end
	end
	if hit == 1
		continue;
	end
	img = imread(strcat('ImagesTrain/',s));
    %catch
     %   img = imread(strcat('LeonCrop/',num2str(cell2mat(s(end)))));
    %end
    %img = imread(strcat('imgs/',num2str(cell2mat(s(end)))));
    %gray_img = rgb2gray(img);
    
    try
       img = img(box(2):box(2)+box(4), box(1):box(1)+box(3), 1:3);
    
    catch
        i
        if box(2)+box(4) > size(img, 1)
            img = img(box(2):size(img, 1), box(1):box(1)+box(3), 1:3);
        elseif box(1)+box(3) > size(img, 2)
            img = img(box(2):box(2)+box(4), box(1):size(img, 2), 1:3);
        end
    end

	imwrite(img, strcat('ImagesTrainCrop/', s));

    %figure;
    %imagesc(img);
end
