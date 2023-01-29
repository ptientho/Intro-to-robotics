function [areasP, centroidsP] = blobAnalysis(imageFile)

% Read image into MATLAB
CD = imread(imageFile);
figure(1)
imshow(CD)
title('Original BW')

threshold = 700;

% Open image by removing connected pixel regions less than 200 pixels in
% size
CDfiltered = bwareaopen(CD, threshold);
figure(2)
imshow(CDfiltered)
title('Opened')
%%
% Fill image
CDfilled = imfill(CDfiltered, 'holes');
figure(3)
imshow(CDfilled)
title('Opened + Filled')
%%
% Label connected components
L = bwlabel(CDfilled);

% Calculate region properties for connected components
s = regionprops(L);

% Concatenate an array of all the region's 'area' values
areas = cat(1, s.Area);

% Concatenate an array of all the region's 'centroid' values
centroids = cat(1, s.Centroid);

areasP = [];
centroidsP = [];

BW2 = zeros(size(L));
threshold = 7000;

while ~isempty(centroids)
    max_area = max(areas);
    idx = find(areas == max_area);
    centX = centroids(idx, 1);
    centY = centroids(idx, 2);
    if max_area > threshold
        BW2 = BW2 + ismember(L, idx);
        areasP = [areasP max_area];
        centroidsP = [centroidsP; centX centY];
        areas(idx) = 0;
    else
        break;
    end
end

% Plot the image of the largest connected region
figure(4)
imshow(BW2)
hold on

l = size(centroidsP);

for i=1:l(1)
    x = centroidsP(i, 1);
    y = centroidsP(i, 2);
    plot(x, y, 'b*');
end

hold off

end