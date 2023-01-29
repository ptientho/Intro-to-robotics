% Left / right
for iter = 2: size(allresults, 2)
figure
subplot(1,2,1);
imshow(allresults(iter).fileName);
title ('Original')
subplot(1,2,2);
imshow(allresults(iter).output)
title('Processed')
end