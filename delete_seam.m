function imresult = delete_seam(im,seam)

    red = im(:,:,1); % Red channel
    green = im(:,:,2); % Green channel
    blue = im(:,:,3); % Blue channel

    [image_x,image_y] = size(red);
    
    %vectorizing each channel to do the delete correctly
    % the idea is given by Dr. Boyd in a discussion after class.
    imr_vector = reshape(red',image_x*image_y,1);
    img_vector = reshape(green',image_x*image_y,1);
    imb_vector = reshape(blue',image_x*image_y,1);
    % I am so happy :D before getting all indexes to delete it takes 11 sec
    % to delete a seam because I delete it one by one but after I sub2ind
    % all of them and then delete them all togheter it become much faster
    % :)
    [dnum,~]=size(seam);
    index=zeros(dnum,1);
    for i=1:image_x
        index(i)=sub2ind([image_y,image_x],seam(i, 1), seam(i, 2));%-(i-1);
    end
        imr_vector(index)=[];
        img_vector(index)=[];
        imb_vector(index)=[];

    %reshape again to the original shape of the image
    imr = reshape(imr_vector',[(image_y-1),(image_x)])';
    img = reshape(img_vector',[(image_y-1),(image_x)])';
    imb = reshape(imb_vector',[(image_y-1),(image_x)])';

    % adding three channels to get a RGB image
    imresult = cat(3, imr, img, imb);
end