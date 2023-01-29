%% Dobot Testing Sample Code

% Author: Prof. Mishah U. Salman
% Last revision: Feb. 22, 2018
% 
% Stevens Institute of Technology
% Mechanical Engineering Department
% ME 598, Introduciton to Robotics


%%

% Clean up the workspace etc. so that variables are clear, as is the
% instrument (COM) configuration
clear all;
close all;
clc;
instrreset

% Configure Dobot parameters for MATLAB communication
serport = 'COM6';
dobot = serial(serport, 'BaudRate' ,9600);

% Establish serial (USB) connection
fopen(dobot)

% Read current Dobot state
% Output the measured configuration and vacuum condition
[q_act, pump] = dobotReadDH(dobot)

%%

% Settings for simulator
multiplot   = 1;
fignummulti = 1; 
fignumXZ    = 2;

figure(fignummulti)
clf

figure(fignumXZ)
clf



% Vacuum parameter: 0=OFF, 1=ON
desSuction = 0;

% Collecting angles of joints from the inverse Kinematics function
q_des = ME598_GrpR3_InvKin(12, 24, 10);

% Some arbitrary configuration
%q_des = [26.9306;59.5060;-70.7972;11.2911;0]%[-20; 5; 0; -5; 90]



% Simulate behavior
dobotPlotXZ(q_des,fignumXZ);
dobotPlot(q_des,fignummulti,multiplot);
    

% Make Dobot move to desired configuration + vacuum state
dobotWriteDH(dobot, q_des, desSuction);

% Pause to give Dobot time to reach commanded configuration
pause(3)

% Read current Dobot state
[q_act, pump] = dobotReadDH(dobot)

% Check configuration error
err_q = q_des - q_act

%%

% Disable Dobot object and release COM port (important)
fclose(dobot)
clear all;
instrreset