%% function result_to_csv(final_test_image_names, final_predicted_categories, categories, file_name)

clear;
clc;

save_file_name = 'submission_chiou_googlenet_txt_rot_resize_final.csv';
zero_file_name = 'zero_image_txt_rot_resize_final.mat';

load('categories.mat');
d = dir(fullfile('kaggle', '*.mat'));
leng = size(categories, 2);
Image = {};

zero_image = {};
zero_count = 0;

for i = 1:leng
	eval(sprintf('%s = zeros(%d, 1);',categories{i}, length(d)));
end

for i = 1:length(d)
	load(['kaggle/', d(i).name]);
	if(class == 0)
		fprintf(['class = 0!! ', fileName, '\n']);
		zero_count = zero_count + 1;
		zero_image = [zero_image; fileName];
		% copyfile(['kaggle/', d(i).name], d(i).name);
		class = 427;
	end
	eval(sprintf('%s(%d, 1) = 1;', categories{class}, i));
	Image = [Image; fileName];
end
fprintf(['zero class number: ', num2str(zero_count), '\n']);
save(zero_file_name, 'zero_image');
% Image = final_test_image_names;
T = table(Image);

for i = 1:leng
	eval(sprintf('T2 = table(%s);', categories{i}));
	eval(sprintf('T = [T T2];'));
end

% Nwhale_90929 = zeros(size(final_test_image_names,1), 1); T = [T table(whale_90929)];

writetable(T, save_file_name)
% writetable(T, file_name)
