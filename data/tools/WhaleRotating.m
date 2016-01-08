for n = 1:size(data,2)
    filename = data{n}.filename;
    x1 = data{n}.fx;
    x2 = data{n}.tx;
    y1 = data{n}.fy;
    y2 = data{n}.ty;
    dx = x1 - x2;
    dy = y1 - y2;
    if dx == 0
        dx = 0.0001;
    end
    slope = dy / dx;

    img = imread(strcat('ImagesTrain/',filename));

    angle = atan(slope) * 57.2957795131 + 90;
    if dx < 0
        angle = angle + 180;
    end
    img_rotate= imrotate(img,angle);
    box = [0 0 0 0];

    [height, width] = size(img);
    width = floor(width / 3);

    x = floor(data{n}.x);
    y = floor(data{n}.y);
    w = floor(data{n}.width);
    h = floor(data{n}.height);
    
    ghost = zeros(height ,width);
    ghost(y: y +1, x:x+1) = 1;
    ghost(y: y +1, x + w-1:x + w) = 1;
    ghost(y + h-1:y + h, x:x+1) = 1;
    ghost(y + h-1:y + h, x + w-1:x + w) = 1;
    rotghost = imrotate(ghost,angle);

    [checky, checkx] = find(rotghost == 1);
    box(2) = min(checky);
    box(1) = min(checkx);
    box(3) = max(checkx) - min(checkx);
    box(4) = max(checky) - min(checky);

    imwrite(img_rotate(box(2):box(2)+box(4), box(1):box(1)+box(3), 1:3), strcat('ImagesTrainCropNewRotated/', filename));
    
end