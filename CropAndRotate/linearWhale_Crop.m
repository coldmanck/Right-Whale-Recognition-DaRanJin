
slope = [];
%d = dir('Right-Whale-Recognition-DaRanJin/result/test_box_new/');
for i = 1:size(toCrop, 2)
    row = [];
    col = [];
  %toCrop(i).imageFilename 
    box = toCrop(i).objectBoundingBoxes;
    %s = strsplit(toCrop(i).imageFilename, '\');
    %try
        img = imread(strcat('ImagesTest/',num2str(cell2mat(toCrop(i).imageFilename))));
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
    
	 imwrite(img, num2str(cell2mat(strcat('ImagesTestCrop/', toCrop(i).imageFilename))));
    %figure;
    %imagesc(img);
end
