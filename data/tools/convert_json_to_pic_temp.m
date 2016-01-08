
fid = fopen('whale_faces_Vinh.json');
raw = fread(fid, inf);
str = char(raw');
fclose(fid);
data = JSON.parse(str);
%save('whale_faces_Vinh.mat', 'data');
save_dir = 'imgs_crop';

for i = 4268:size(data, 2)
	% img = imread('imgs/whale_34663/w_7001.jpg');
	img = imread(data{i}.filename);

	x = floor(data{i}.annotations{1}.x) + 1;
	y = floor(data{i}.annotations{1}.y) + 1;
	height = floor(data{i}.annotations{1}.height) + 1;
	width = floor(data{i}.annotations{1}.width) + 1;

	img2 = img(y:y + height, x:x + width, :);
	% imwrite('w_7001_crop.jpg', img2);
	file_strs = strsplit(data{i}.filename, '/');

	save_path = char( fullfile(save_dir, file_strs(end-1)) ); % 'imgs_crop/whale_34663/w_7001.jpg'
	if ~exist(save_path, 'dir')
		mkdir(save_path);
	end
	imwrite(img2, char( fullfile(save_path, file_strs{end}) ));
end
