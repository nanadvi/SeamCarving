function [reducedColorImg,reducedEnergyImg] = decrease_width(im,energyImg)
    [dim1, dim2, dim3] = size(im);
    % width --
    reducedColorImg = zeros(dim1, dim2-1, dim3, 'uint8');
    % find the seam
    energyMap = cumulative_min_energy_map(energyImg, 'VERTICAL');
    verticalSeam = find_veritcal_seam(energyMap);
    for i=1:dim1
        yId = verticalSeam(i);
        temp = [1:yId-1 yId+1:dim2];
        reducedColorImg(i,:,:) = im(i, temp, :);
    end
    reducedEnergyImg = energy_img(reducedColorImg);
end