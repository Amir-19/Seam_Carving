% exactly same as delete seam but for gray scale images.
function imresult = delete_seam_gray(im,seam)

    
    [image_x,image_y] = size(im);
    im_vector = reshape(im',image_x*image_y,1);
    [dnum,~]=size(seam);
    index=zeros(dnum,1);
    for i=1:image_x
        index(i)=sub2ind([image_y,image_x],seam(i, 1), seam(i, 2));
    end
        im_vector(index)=[];
    imresult = reshape(im_vector',[(image_y-1),(image_x)])';
end