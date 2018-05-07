function seam_carving_decrease_width()
    pixel_to_reduce = 100;
    inputSeamCarvingPrague = imread('inputSeamCarvingPrague.jpg');
    energy_img_prague = energy_img(inputSeamCarvingPrague);
    [inputSeamCarvingPragueReduced,~,pixelReduced] = seam_carving_decrease_width_helper(inputSeamCarvingPrague, energy_img_prague, pixel_to_reduce);
    imwrite(inputSeamCarvingPragueReduced,'outputReduceWidthPrague.png');
    close;
    inputSeamCarvingMall = imread('inputSeamCarvingMall.jpg');
    energy_img_mall = energy_img(inputSeamCarvingMall);
    [inputSeamCarvingMallReduced,~,pixelReduced] = seam_carving_decrease_width_helper(inputSeamCarvingMall, energy_img_mall, pixel_to_reduce);
    imwrite(inputSeamCarvingMallReduced, 'outputReduceWidthMall.png');
    close;
end

function [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_width_helper(inputImg, energyImg, pixel)
    if(pixel == 0)
        reducedImg = inputImg;
        reducedEnergyImg = energyImg; 
        pixelReduced = pixel;
        return
    else
        pixel = pixel-1;
        imagesc(inputImg);
        drawnow();
        [reducedImg_, reducedEnergyImg_] = decrease_width(inputImg, energyImg);
        [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_width_helper(reducedImg_, reducedEnergyImg_, pixel);
    end
end