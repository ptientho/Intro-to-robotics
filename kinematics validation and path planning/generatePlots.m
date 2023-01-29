function generatePlots(coordinates)
x = [];
y = [];
z = [];
for i=1:length(coordinates)
    point = coordinates{i};
    x(end+1) = point(1);
    y(end+1) = point(2);
    z(end+1) = point(3);
end

figure(10);
clf;
plot3(x, y, z, 'o-blue');

end