function result_to_csv(final_test_image_names, final_predicted_categories, categories, file_name)

%load('final_test_image_names.mat');
%load('final_predicted_categories.mat');
%load('categories.mat');

leng = size(categories, 2);
for i = 1:leng
	eval(sprintf('%s = zeros(%d, 1);',categories{i}, size(final_test_image_names,1)));
end

for i = 1:size(final_test_image_names ,1)
	eval(sprintf('%s(%d, 1) = 1;', final_predicted_categories{i}, i));
end

Image = final_test_image_names;
T = table(Image);
for i = 1:leng
	eval(sprintf('T2 = table(%s);', categories{i}));
	eval(sprintf('T = [T T2];'));
end

whale_22848 = zeros(size(final_test_image_names,1), 1); T = [T table(whale_22848)];
whale_51114 = zeros(size(final_test_image_names,1), 1); T = [T table(whale_51114)];
whale_54497 = zeros(size(final_test_image_names,1), 1); T = [T table(whale_54497)];
whale_88226 = zeros(size(final_test_image_names,1), 1); T = [T table(whale_88226)];
whale_90929 = zeros(size(final_test_image_names,1), 1); T = [T table(whale_90929)];

%writetable(T,'submission_chiou.csv')
writetable(T, file_name)
