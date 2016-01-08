final_test_image_paths = {};
final_test_image_names = {};

for i = 3:size(test_images_dir, 1)
    final_test_image_paths = [final_test_image_paths; ['../ImagesTestCrop/' ,test_images_dir(i).name]];
    final_test_image_names = [final_test_image_names; test_images_dir(i).name];
end

final_vocab_size = 500;
if ~exist(['final_test_image_feats_size', num2str(final_vocab_size),'.mat'])
    final_test_image_feats  = get_bags_of_sifts(final_test_image_paths, final_vocab_size, max_time);
    save(['final_test_image_feats_size', num2str(final_vocab_size),'.mat'], 'final_test_image_feats');
else
    load(['final_test_image_feats_size', num2str(final_vocab_size),'.mat']);
end

% Train by linear svm
final_predicted_categories = svm_classify(final_train_image_feats, final_train_labels, final_test_image_feats);
save('final_result.mat', 'final_test_image_names', 'final_predicted_categories');
