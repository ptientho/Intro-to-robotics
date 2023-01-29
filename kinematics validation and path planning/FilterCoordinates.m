%load coordinate set
clearvars

load('coor_sets_Lab2_part4.mat');
[x_filtered, z_filtered] = check_obstacles(xVals,zVals);
path_new = connect_path(x_filtered, z_filtered);

%plot workspace
figure(1)
plot(x_filtered, z_filtered,'x')

axis equal
xlim([10, 40])
ylim([0, 20])

grid minor
grid

xlabel('X coordinate [cm]')
ylabel('Z coordinate [cm]')
title('Dobot X0-Z0 Plane Workspace')