% Plot XY
figure(1)
plot(xPose,yPose)
title('Overhead XY Plot of Robot Trajectory')
xlabel ('X_I [m]')
ylabel ('Y_I [m]')

% Plot thea vs. time
figure(2)
plot(tout,360/(2*pi)*tPose)
title('Robot Orientation \theta vs. Time')
xlabel ('Time [sec]')
ylabel ('\theta [deg]')