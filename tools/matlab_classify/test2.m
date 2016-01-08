load('../training_data.mat');
categories = {};

for i = 1:size(training_data, 2)
	categories = [categories, training_data(i).imageClass];
end

categories = unique(categories);
