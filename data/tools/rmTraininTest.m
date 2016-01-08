train = dir('ImagesTrain');
train(1:3) = [];
test = dir('ImagesTest');
test(1:2) = [];

for i = 1:size(train, 1)
	hit = 0;
    s = strsplit(train(i).name, '.');
    s = num2str(cell2mat(strcat(s(1), '.', s(2))));
    for j = 1:size(test, 1)
        if strcmp(s, test(j).name) == 1
            hit = 1;
			break;
        end
    end
	if hit == 1
		continue;
	end
	img = imread(strcat('ImagesTrain/', s));
	imwrite(img, strcat('ImagesTrainCrop/', s));
	
end
