function image_feats = spatial_pyramid(image_paths, vocab_size, t)

load(['vocab_SPSG_size', num2str(vocab_size), '_t', num2str(t),'.mat']);
N = size(image_paths , 1);
vocab_size = size(vocab, 1);

% We use Level 0 , 1 , 2 , so there will be 1 + 4 + 16 = 21 histogram
image_feats = zeros(N , 21 * vocab_size);

% Construct pyramid cell array
pyramidLevels = 3;
pyramidCell = cell(pyramidLevels , 1);

for i = 1 : N
    imgPath = image_paths(i);
    imgCurrentRead = imread(char(imgPath));
    [Height , Width , Channels] = size(imgCurrentRead);
    
    a = 4;
    pyramidCell{1} = zeros(a , a , vocab_size);
    % Level 2
    for j = 1 : a
        for k = 1 : a
            xMin = floor((Width / a) * (j - 1));
            xMax = floor((Width / a) * j);
            yMin = floor((Height / a) * (k - 1));
            yMax = floor((Height / a) * k);
            
            img = imgCurrentRead((yMin + 1 : yMax) , (xMin + 1 : xMax));
            [locations, SIFT_features] = vl_dsift(im2single(img) , 'step' , 3);
            % [locations, SIFT_features] = vl_dsift(im2single(img) , 'fast');
            Dist = vl_alldist2(double(vocab') , double(SIFT_features));
            [minDistValue , minDistIndex] = min(Dist);
            histopyramid = hist(double(minDistIndex) , vocab_size);
            normalizedHistopyramid = histopyramid / sum(histopyramid);
            
            pyramidCell{1}(j , k , :) = normalizedHistopyramid;
        end
    end
    
    % Level 1
    b = a / 2;
    pyramidCell{2} = zeros(b , b , vocab_size);
    for j = 1 : b
        for k = 1 : b
            xMin = floor((Width / b) * (j - 1));
            xMax = floor((Width / b) * j);
            yMin = floor((Height / b) * (k - 1));
            yMax = floor((Height / b) * k);
            
            img = imgCurrentRead((yMin + 1 : yMax) , (xMin + 1 : xMax));
            [locations, SIFT_features] = vl_dsift(im2single(img) , 'step' , 3);
            % [locations, SIFT_features] = vl_dsift(im2single(img) , 'fast');
            Dist = vl_alldist2(double(vocab') , double(SIFT_features));
            [minDistValue , minDistIndex] = min(Dist);
            histopyramid = hist(double(minDistIndex) , vocab_size);
            normalizedHistopyramid = histopyramid / sum(histopyramid);
            
            pyramidCell{2}(j , k , :) = normalizedHistopyramid;
        end
    end
    
    % Level 0
    c = a / 4;
    pyramidCell{3} = zeros(c , c , vocab_size);
    for j = 1 : c
        for k = 1 : c
            xMin = floor((Width / c) * (j - 1));
            xMax = floor((Width / c) * j);
            yMin = floor((Height / c) * (k - 1));
            yMax = floor((Height / c) * k);
            
            img = imgCurrentRead((yMin + 1 : yMax) , (xMin + 1 : xMax));
            [locations, SIFT_features] = vl_dsift(im2single(img) , 'step' , 3);
            % [locations, SIFT_features] = vl_dsift(im2single(img) , 'fast');
            Dist = vl_alldist2(double(vocab') , double(SIFT_features));
            [minDistValue , minDistIndex] = min(Dist);
            histopyramid = hist(double(minDistIndex) , vocab_size);
            normalizedHistopyramid = histopyramid / sum(histopyramid);
            
            pyramidCell{3}(j , k , :) = normalizedHistopyramid;
        end
    end
    
    
    % Sum up all the pyramide cell
    pyramid = [];
    
    for x = 1 : (pyramidLevels - 1)
        pyramid = [pyramid pyramidCell{x}(:)' .* 2^(-x)];
    end
    pyramid = [pyramid pyramidCell{pyramidLevels}(:)' .* 2^(1 - pyramidLevels)];
    
    image_feats(i , :) = pyramid';
    
end

end




