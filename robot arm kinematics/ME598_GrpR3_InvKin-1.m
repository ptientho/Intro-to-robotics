function q = ME598_GrpR3_InvKin(Px, Py, Pz)

%Defining the the fixed values (i.e. arm length and theta_5)
d1 = 10.5;
a2 = 13.5;
a3 = 16;
a4 = 5.5;
d5 = 7;
theta_5d = 0;                                   

try 
    theta_1r = atan2(Py,Px);                    %theta 1 in radians
    theta_1d = theta_1r*180/pi;

    x1 = Px/cos(theta_1r) - a4;
    y1 = Pz - d1 + d5;
    x3 = (x1^2+y1^2-a2^2-a3^2) / (2*a2*a3);
    
    theta_3r = -acos(x3);                   %theta 3 in radians
    theta_3d = theta_3r*180/pi;

    x2 = a2 + a3*cos(theta_3r);
    y2 = a3*sin(theta_3r);
    theta_2r = atan2(y1,x1) - atan2(y2,x2);     %theta 2 in radians 
                                                %due to the +5 to +95
                                                %constrain the two angles
                                                %are always subtracted.
    theta_2d = theta_2r*180/pi;

    theta_4d = -(theta_2d + theta_3d);          %theta 4 in degrees.
    
    if( (130 < theta_1d) || (theta_1d < -130) || (theta_2d < 5) || (theta_2d > 95) || (theta_4d < -5) || (theta_4d > 85) )
        error("Warning! End effector beyond robot workspace!");
    end

     q = [theta_1d; theta_2d; theta_3d; theta_4d; theta_5d];

catch
    error("Warning! End effector beyond robot workspace!")
end

   

            

