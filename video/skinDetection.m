function binaryImage = skinDetection(img)
height = size(img,1);
width = size(img,2);

bin = zeros(height,width);

%Compensation
img = grayworld(img);

%Convert the image from RGB to YCbCr
[hue,~,~]=rgb2hsv(img);    %converting RGB space into HSV space
img_ycbcr = rgb2ycbcr(img);
Cb = img_ycbcr(:,:,2);
Cr = img_ycbcr(:,:,3);

%Detect Skin
[r,c,~] = find(Cb>=77 & Cb<=127 & Cr>=133 & Cr<=173 & 0.01<=hue & hue<=0.15);
numind = size(r,1);

%Mark Skin Pixels
for i=1:numind
    bin(r(i),c(i)) = 1;
end

binaryImage=im2bw(bin,graythresh(bin));
binaryImage = imfill(binaryImage, 'holes');
binaryImage = bwareaopen(binaryImage, 50);