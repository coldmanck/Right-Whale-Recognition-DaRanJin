train_image_paths = {};
test_image_paths = {};
train_labels = {};
test_labels = {};

load('../training_data.mat');
train_size = 0.9;
train_numbers = randsample(size(training_data, 2), int16(train_size * size(training_data, 2)));
test_all = [];
for i = 1:size(training_data, 2)
    test_all = [test_all; i];
end
test_numbers = setdiff(test_all, train_numbers, 'rows');

for i = 1:size(train_numbers,1) % size(training_data, 2)
    train_image_paths = [train_image_paths; ['../ImagesTrainCrop/' ,...
                         training_data(train_numbers(i, 1)).imagePath]];
    train_labels = [train_labels; training_data(train_numbers(i, 1)).imageClass];
end

for i = 1:size(test_numbers,1)
    test_image_paths = [test_image_paths; ['../ImagesTrainCrop/' ,...
                         training_data(test_numbers(i, 1)).imagePath]];
    test_labels = [test_labels; training_data(test_numbers(i, 1)).imageClass];
end
