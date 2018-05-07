function [reducedColorImg,reducedEnergyImg] = decrease_height(im,energyImg)
    [dim1, dim2, dim3] = size(im);
    % width --
    reducedColorImg = zeros(dim1-1, dim2, dim3, 'uint8');
    % find the seam
    cumulativeEnergyMap = cumulative_min_energy_map(energyImg, 'HORIZONTAL');
    seam = find_horizontal_seam(cumulativeEnergyMap);
    for i=1:dim2
        xId = seam(i); 
        r = [1:xId-1, xId+1:dim1];
        temp = im(r , i, :);
        reducedColorImg(:,i,:) = temp;
    end
    reducedEnergyImg = energy_img(reducedColorImg);
end 