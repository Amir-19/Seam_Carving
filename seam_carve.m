%if isHorizantal is 1 we do the operation horizantally but otherwise we
%do it vertically
%
%num is the number of time to do seam_carving
function imresult = seam_carve(im,isHorizantal,num)


    if (isHorizantal==1)
        im = flipud(imrotate(im,90));
    end
    imresult=im;
    [image_x,image_y,colors]=size(im);
    for i=1:num
        energy_dp = dynamic_programming_seam(imresult); 
        seams = backtrack_seam(energy_dp);
        if (colors==1)
            imresult = delete_seam_gray(imresult,seams);
        else
            imresult = delete_seam(imresult,seams);
        end
    end
    
    if (isHorizantal==1)
        imresult = flipud(imrotate(imresult,90));
    end

end