function energy = gaussian_gradinet(img)
    % Convert the image to grey-scaled
    grey_scaled = im2double(rgb2gray(img));
    kernel = fspecial('gaussian',[10 10],3);
    filtered_ = grey_scaled +imfilter(grey_scaled,kernel,'conv', 'replicate');
    filtered = edge(filtered_,'Canny');
    [Gx,Gy] = imgradientxy(filtered);
    energy = sqrt(Gx.^2 + Gy.^2);
    imshowpair(img, energy,'montage');
end