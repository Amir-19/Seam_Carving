im = (imread('boat.jpg'));

imresult=seam_carve(im,0,200);
imresult=seam_carve(imresult,1,200);

figure(1);
imshow(im);

figure(2);
imshow(imresult);