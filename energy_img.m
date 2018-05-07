function energy = energy_img(img)
    % Convert the image to grey-scaled
    grey_scaled = im2double(rgb2gray(img));
    [Gx,Gy] = imgradientxy(grey_scaled);
    energy = sqrt(Gx.^2 + Gy.^2);
end
