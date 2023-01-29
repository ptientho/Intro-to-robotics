function [angles, proximities] = get_3b(imgBW, centroids, areas)
    %input: image with centroid(s) and BW image
    %orientation of the centroid(s) compared with the robot's FOV
    
    %dimension:
        %imgBW = MxN
        %centroids = axa (square)
        %areas = bx1 (vector)
    
    %check if areas is empty
    if isempty(areas)
        error('No cone is in the image; areas is empty')
    end

    %angle reference(degree)
    refAngle = zeros(length(centroids(:,1)),1);
    %proximity reference
    maxThreshold = 43000;
    minThreshold = 8500;
    refProx = maxThreshold - minThreshold;
    
    %get number of rows and columns of the image
    [nr, nc] = size(imgBW);
    %image center X
    imageCenterX = nc/2;
    %compare x distance with the image center x
    xDiff = centroids(:,1) - imageCenterX;

    %angles(output)
    angles = zeros(size(refAngle));
    proximities = zeros(size(refAngle));
    
    %find orientation
    for idx = 1:length(refAngle)
        if xDiff(idx) <= 0
            %refAngle = +30
            refAngle(idx) = 30;
            %angle(idx) in radian
            angles(idx) = asin(sin(deg2rad(refAngle(idx)))*(abs(xDiff(idx))/imageCenterX));
            %angle(idx) in degree
            angles(idx) = rad2deg(angles(idx));
        else
            %refAngle = -30
            refAngle(idx) = -30;
            %angle(idx) in radian
            angles(idx) = asin(sin(deg2rad(refAngle(idx)))*(abs(xDiff(idx))/imageCenterX));
            %angle(idx) in degree
            angles(idx) = rad2deg(angles(idx));
        end
    end
    angles = angles';

    %find proximity
    refProx = refProx/3; %3 proximities: 1(near) 2(middle) 3(far)
    for idx = 1:length(refAngle)
        if areas(idx) <= 1*refProx %far
            proximities(idx) = 3;
        elseif areas(idx) > 1*refProx && areas(idx) <= 2*refProx %(middle)
            proximities(idx) = 2;
        else
            proximities(idx) = 1; %near
        end
    end
    proximities = proximities';

end