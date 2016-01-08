d = dir('~/Right-Whale-Recognition-DaRanJin/result/test_box_new');
d(1:2) = [];

slope = [];
prob_name = {};

for i = 1:size(index, 2)
    row = [];
    col = [];
    object = strcat('~/Right-Whale-Recognition-DaRanJin/result/test_box_new/', d(index(i)).name); 
    load(object);
    box = img_bbox;
    %s = strsplit(toCrop(i).imageFilename, '\');
    %try
        img = imread(strcat('ImagesTest/',img_path));
    %catch
     %   img = imread(strcat('LeonCrop/',num2str(cell2mat(s(end)))));
    %end
    %img = imread(strcat('imgs/',num2str(cell2mat(s(end)))));
    %gray_img = rgb2gray(img);
    
    try
        img = img(box(1):box(1)+box(3), box(2):box(2)+box(4), 1:3);
    catch
		i
        index(i)
		if box(1) == 0 
			box(1) = 1;
		end
		if box(2) == 0
			box(2) = 1;
		end
											             
		if box(1)+box(3) > size(img, 1)
			img = img(box(1):size(img, 1), box(2):box(2)+box(4), 1:3);
		elseif box(2)+box(4) > size(img, 2)
			img = img(box(1):box(1)+box(3), box(2):size(img, 2), 1:3);
		else
			img = img(box(1):box(1)+box(3), box(2):box(2)+box(4), 1:3);
		end
	end
	imwrite(img,strcat('ImagesTestCrop/', img_path));    
    %figure;
    %imagesc(img);
end
