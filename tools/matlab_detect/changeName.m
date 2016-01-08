d = dir('imgs_neg');

for i = 3:size(d)
    dirName = d(i).name;
    d2 = dir(['imgs_neg', '/', dirName]);
    for j = 3:size(d2)
        movefile(['imgs_neg', '/', dirName, '/', d2(j).name], ['imgs_neg', '/', dirName, '_', d2(j).name]);
    end
end