function captureImage(name)
mycam = webcam;
snap = snapshot(mycam);
figure(1);
imshow(snap);
saveas(gcf, name, 'jpg');
delete(mycam);
end
