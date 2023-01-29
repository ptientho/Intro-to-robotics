function moveDobotAlong(ps, suctionStates, simulate, dobotPlatform)

%%

% Clean up the workspace etc. so that variables are clear, as is the
% instrument (COM) configuration
clc;
instrreset

% Configure Dobot parameters for MATLAB communication
serport = 'COM6';
dobot = serial(serport, 'BaudRate' ,9600);

% Establish serial (USB) connection
fopen(dobot);

% Read current Dobot state
% Output the measured configuration and vacuum condition
[~, ~] = dobotReadDH(dobot);

% Settings for simulator
multiplot   = 1;
fignummulti = 1; 
fignumXZ    = 2;

figure(fignummulti)
clf

figure(fignumXZ)
clf

for k = 1:length(ps)
    
    %disp(k)
    %disp(ps{k})

    q = ME598_GrpR3_InvKin(ps{k});

    if simulate
        % Simulate behavior
        dobotPlotXZ(q,fignumXZ);
        dobotPlot(q,fignummulti,multiplot);
    end

    if dobotPlatform
        dobotWriteDH(dobot, q, suctionStates(k));
    end

    pause(1)

end    

% Disable Dobot object and release COM port (important)
fclose(dobot);
instrreset

end