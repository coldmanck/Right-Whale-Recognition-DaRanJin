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
    
    %figure;
    %imagesc(img);
    gray_img = rgb2gray(img);
    average = sum(sum(gray_img)) / (size(gray_img, 1) * size(gray_img, 2));
    
    for j = 1:size(gray_img, 1)
    for k = 1:size(gray_img, 2)
        %for k = 1:size(a, 3)
            if gray_img(j, k) <= average + 10 || gray_img(j, k) >= 200
                gray_img(j, k) = 0;
            else
                gray_img(j, k) = 255;
                num = (size(gray_img, 1) - j);
                row = [row num];
                %num = (size(gray_img, 2) - k)
                col = [col k];
            end
    end
    end
    %figure;
    %imshow(gray_img);
    %figure;
    %linearCoef = polyfit(col,row,1);
    %linearFit = polyval(linearCoef,col);
   % plot(col,row,'s', col,linearFit,'r-', [0 247],[0 0],'k:', [0 247],[1 1],'k:')
   %plot(col,row,'*') 
   %h = lsline;
   %set(h, 'color', 'r')
    p = polyfit(col, row, 1);
    %imwrite(img, strcat('ImagesTestRotate/', img_path));
    angle = atan(p(1)) * 90;
    img_rotate= imrotate(img,angle,'bilinear','crop');
    try
     imwrite(img_rotate, strcat('ImagesTestRotatebyCrop/', img_path));
     slope = [slope p(1)];
    catch
     prob_name{end+1} = d(index(i)).name;
    end
   %p2 = polyfit(get(h,'xdata'),get(h,'ydata'),1);
   % mdl = LinearModel.fit(mat2dataset(double(gray_img)));
   % figure;
   % plot(mdl);
end
