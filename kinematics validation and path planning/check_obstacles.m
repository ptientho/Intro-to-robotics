%check points below z=3.9 are obstables
function [x_filtered, z_filtered] = check_obstacles(x,z)

   x_filtered = [];
   z_filtered = [];

   for i = 1:length(x)
       if x(i) > 18 && x(i) < 31.5 && z(i) > 3.9
           x_filtered(end+1) = x(i);
           z_filtered(end+1) = z(i);
       end
   end
end