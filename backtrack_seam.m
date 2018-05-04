% acctually this is pretty easy but as I read the code of back track of 
%http://www.mathworks.com/matlabcentral/fileexchange/46227-seam-carving-with-dijkstra-and-dynamic-programming
% I think I need to cite it.
function seam = backtrack_seam(energy_dp)

[image_x, image_y] = size(energy_dp);
%this is the seam and we have x,y of the seam in each row
seam  = zeros(image_x, 2);
% we find the minmum of the last row and start from there because the
% minumum in the last row is the start of the best seam
[minimum, index_of_minumum] = min(energy_dp(image_x,:));
seam(image_x, :) = [index_of_minumum image_x];
for i = image_x-1:-1:1
    
    %for the first column we only need to consider top and top right
    if ( index_of_minumum == 1 )
        [minimum, index_of_minumum] = min(energy_dp(i,1:2));
    %for the last column we only need to consider top and top left
    elseif ( index_of_minumum == image_y )
        [minimum, index_of_minumum] = min(energy_dp(i,image_y-1:image_y));
        % as the minimum location is locally found here we need to find it
        % in the original array
        index_of_minumum = index_of_minumum + image_y - 2;
    else
        last_min = index_of_minumum;
        [minimum, index_of_minumum] = min(energy_dp(i,index_of_minumum-1:index_of_minumum+1));
        % as the minimum location is locally found here we need to find it
        % in the original array
        index_of_minumum = last_min + index_of_minumum - 2;
    end
    seam(i, :) = [index_of_minumum i];
end

