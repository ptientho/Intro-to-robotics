function coordis = ME598_GrpR3_FwdKin(confs)
%Error throw1 : the confs size must satisfy 5x1, check matrix dimension
    if length(confs) < 5 || length(confs) > 5
        error('The number of degrees input in array must be equal to 5 (base, shoulder, elbow, wrist, twist)');
    end
%Error throw2 : check 1: Base, Shoulder, and Twist joints are within ranges
    if confs(1) < -130 || confs(1) > 130 %base joint beyond range
        error('Warning! Base angle beyond robot workspace!');
    elseif confs(2) < 5 || confs(2) > 95 %shoulder joint beyond range
        error('Warning! Shoulder angle beyond robot workspace!');
    elseif confs(4) < -5 || confs(4) > 85 %wrist joint beyond range
        error('Warning! Wrist angle beyond robot workspace!');
    elseif confs(5) < -90 || confs(5) > 90 %twist joint beyond range
        error('Warning! Twist angle beyond robot workspace!');
    elseif confs(2) + confs(3) + confs(4) ~= 0
        error('Warning! Joint angles violate mechanical constraints on wrist.')
    else %within robot workspace
        [x,y,z,cup_dir] = fwd_kin(confs);
        if cup_dir < 0
            coordis = [x;y;z];
        else
            error('cup is not in downward direction');
        end

    end

end

%% Function involves in part3
function T = trans_f(d,theta,a,alpha) %input unit in cm and rad
    R_z = [cos(theta)  -sin(theta)  0 0;
           sin(theta)  cos(theta)   0 0;
           0            0           1 0;
           0            0           0 1];
    T_z = [1 0 0 0;
           0 1 0 0;
           0 0 1 d;
           0 0 0 1];
    T_x = [1 0 0 a;
           0 1 0 0;
           0 0 1 0;
           0 0 0 1];
    R_x = [1        0       0        0;
            0 cos(alpha) -sin(alpha) 0;
            0 sin(alpha) cos(alpha)  0;
            0       0       0        1];

    T = R_z*T_z*T_x*R_x;
end


function [x,y,z,cup_dir] = fwd_kin(confs) %input unit in cm and degrees
    q_base = deg2rad(confs(1));
    q_shoulder = deg2rad(confs(2));
    q_elbow = deg2rad(confs(3));
    q_wrist = deg2rad(confs(4));
    q_twist = deg2rad(confs(5));

    %transforming frames
    T_01 = trans_f(10.5,q_base,0,deg2rad(90));
    T_12 = trans_f(0,q_shoulder,13.5,0);
    T_23 = trans_f(0,q_elbow,16,0);
    T_34 = trans_f(0,q_wrist,5.5,deg2rad(90));
    T_45 = trans_f(7,q_twist,0,0);

    T_05 = T_01 * T_12 * T_23 * T_34 * T_45;
    x = T_05(1,4);
    y = T_05(2,4);
    z = T_05(3,4);
    cup_dir = dot([0;0;1],[T_05(1,3);T_05(2,3);T_05(3,3)]);

end
