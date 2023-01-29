function q = readDobotPosition()

% Clean up the workspace etc. so that variables are clear, as is the
% instrument (COM) configuration
close all;
clc;
instrreset

% Configure Dobot parameters for MATLAB communication
serport = 'COM6';
dobot = serial(serport, 'BaudRate' ,9600);

% Establish serial (USB) connection
fopen(dobot);

% Read current Dobot state
% Output the measured configuration and vacuum condition
[q, ~] = dobotReadDH(dobot);

instrreset

end