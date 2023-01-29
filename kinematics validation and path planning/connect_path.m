%this function take coordinates(x,z) as input
%output: nearest points from the reference point

function path_new = connect_path(x,z)

    path = zeros(length(x),2);
    for i = 1:length(x)
        path(i,:) = [x(i), z(i)];
    end
    
    path_new = zeros(length(x),2); %initial path_new var array
    start_pos = path(1,:); %get start_pos
    path_new(1,:) = start_pos; %assign start_pos to path_new
    for i = 1:length(x)
        curr_pos = path_new(i,:); %point to compare cost
        if i == length(x)
            break
        end
        cost = zeros(1,length(x)); %initial cost var
        
        for j = 1:length(x) %assign cost array
            next_pos = path(j,:);
            if i > 1 && ismember(next_pos(1),path_new(:,1)) && ismember(next_pos(2),path_new(:,2))
                cost(j) = 0; %robot stay at the same pos and previous points are already considered!
            else %calculate distance to all points from point ith
                cost(j) = sqrt((curr_pos(1)-next_pos(1))^2 + (curr_pos(2)-next_pos(2))^2); %cost function defining absolute distance
            end
        end
        
        indx_nonzeros = find(cost); %find index of nonzeros cost
        min = cost(indx_nonzeros(1)); %first nonzero cost as min
        n = 1; %initial min and I index
        for k = 1:length(cost)
            if cost(k) == 0 %neglect cost = 0
                continue
            else %consider cost != 0
                if cost(k) <= min
                    min = cost(k);
                    n = k;
                end
            end
        end
        path_new(i+1,:) = path(n,:); %add the minimum distance point to the last element array
    end   