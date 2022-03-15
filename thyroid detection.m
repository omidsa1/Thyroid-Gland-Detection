% load image and force grayscale
I = imread('./thyroid-norm.jpg');
I = rgb2gray(I);

% apply binary mask based on varying contrasts
[~,threshold] = edge(I,'sobel');
fudgeFactor = 0.5;
BWs = edge(I,'sobel',threshold * fudgeFactor);

% morphological dilation  
se90 = strel('line',3,90);
se0 = strel('line',3,0);
BWsdil = imdilate(BWs,[se90 se0]);

% fill in the gaps 
BWdfill = imfill(BWsdil,'holes');

% erode the thyroid gland
seD = strel('diamond',1);
BWfinal = imerode(BWdfill,seD);
BWfinal = imerode(BWfinal,seD);

% plot result of each step 
subplot(3,2,1), imshow(I), title('Step 1')
subplot(3,2,2), imshow(BWs), title('Step 2')
subplot(3,2,3), imshow(BWsdil), title('Step 3')
subplot(3,2,4), imshow(BWdfill), title('Step 4')
subplot(3,2,5), imshow(BWfinal), title('Step 5')
subplot(3,2,6), imshow(labeloverlay(I,BWfinal)), title('Step 6')
