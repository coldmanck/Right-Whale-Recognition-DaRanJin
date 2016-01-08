%% Read data
fid = fopen('train.csv');
out = textscan(fid,'%s%s','delimiter',',');

d = dir('ImagesTrainCrop');

%% get training data
field1 = 'imagePath';
field2 = 'imageClass';
value1 = {};
value2 = {};
for i = 3:size(d,1)
	for j = 1:size(out{1,1},1)
		if(strcmp(d(i).name, out{1,1}(j)) == 1)
			value1 = [value1, out{1,1}(j)];
			value2 = [value2, out{1,2}(j)];
			break;
		end
	end
end
training_data = struct(field1, value1, field2, value2);

save('training_data.mat', 'training_data');
