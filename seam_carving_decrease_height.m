function seam_carving_decrease_height()
    pixel_to_reduce = 50;
    inputSeamCarvingPrague = imread('inputSeamCarvingPrague.jpg');
    energy_img_prague = energy_img(inputSeamCarvingPrague);
    [inputSeamCarvingPragueReduced,~,pixelReduced] = seam_carving_decrease_height_helper(inputSeamCarvingPrague, energy_img_prague, pixel_to_reduce);
    imwrite(inputSeamCarvingPragueReduced,'outputReduceHeightPrague.png');
    close;
    inputSeamCarvingMall = imread('inputSeamCarvingMall.jpg');
    energy_img_mall = energy_img(inputSeamCarvingMall);
    [inputSeamCarvingMallReduced,~,pixelReduced] = seam_carving_decrease_height_helper(inputSeamCarvingMall, energy_img_mall, pixel_to_reduce);
    imwrite(inputSeamCarvingMallReduced, 'outputReduceHeightMall.png');
    close;
    
end

function [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_height_helper(inputImg, energyImg, pixel)
    if(pixel == 0)
        reducedImg = inputImg;
        reducedEnergyImg = energyImg; 
        pixelReduced = pixel;
        return
    else
        pixel = pixel-1;
        imagesc(inputImg);
        drawnow();
        [reducedImg_, reducedEnergyImg_] = decrease_height(inputImg, energyImg);
        [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_height_helper(reducedImg_, reducedEnergyImg_, pixel);
    end
end