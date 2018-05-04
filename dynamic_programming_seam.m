function energy_dp = dynamic_programming_seam(im)

    [image_x, image_y, colors] = size(im);

    energy = zeros(image_x, image_y);
    for color = 1:colors
        % find energy of each dimention and add them together
        energy = energy + find_gradient_with_smoothing(double(im(:, :, color)));
    end

    energy_temp = zeros(3,image_y);
    energy_dp = zeros(image_x, image_y);
    %first row is the energy it self
    energy_dp(1, :) = energy(1, :);
    %but the other rows need to be calculated from the previous ros
    for i = 2:image_x
        % for fast matrix calculation instead of for loop I made three
        % array and merge them togheter first row is the original top
        % array, second row is the shifting 1 to right and placing infinity
        % to start and the third row is shifting to left and place infinity
        % at the end of the array.
        energy_temp(1,:)=energy_dp(i-1,:);
        energy_temp(2,:)=[inf ,energy_dp(i-1,1:end-1)];
        energy_temp(3,:)=[energy_dp(i-1,2:end),inf];
        energy_dp(i,:)=energy(i,:)+min(energy_temp);    
    end

end

% get the idea in a talk with Dr. Boyd
function gradient = find_gradient_with_smoothing(I)

    gradient = abs(imfilter(I, [-1,0,1], 'replicate')) + abs(imfilter(I, [-1;0;1], 'replicate'));
end