function crop(img)
    [sourceFolder, baseFileNameNoExtenstion, ext] = fileparts(img);
    destinationFolder = ['result','/', baseFileNameNoExtenstion];
    if ~exist(destinationFolder, 'dir')
        mkdir(destinationFolder);
    end
    img_ = imread(img);
    [dim1, dim2, ~] = size(img_);
    cropWidth = dim1/3;
    cropHeight = dim2/2;
    for i=1:40:cropWidth
        reducedImgW = seam_carving_decrease_width(i, img_); 
        for j= i:30:cropHeight
            
            reducedImgH = seam_carving_decrease_height(i, reducedImgW);
            disp(size(reducedImgH));
            imshow(reducedImgH);
            [W, H, ~] = size(reducedImgH);
            title(['HEIGHT: ' num2str(H) ' WIDTH: ' num2str(W)]); 
            outputBaseName = [baseFileNameNoExtenstion,'_',num2str(W),'_',num2str(H),'_','.JPG'];
            fullDestinationFileName = fullfile(destinationFolder, outputBaseName);
            drawnow();
            imwrite(reducedImgH,fullDestinationFileName);
        end
        
    end
end

function inputSeamCarvingPragueReduced = seam_carving_decrease_height(pixel_, im)
    inputSeamCarvingPrague = im;
    pixelReduced = pixel_;
    energy_img_prague = energy_img(inputSeamCarvingPrague);
    [inputSeamCarvingPragueReduced,~,pixelReduced] = seam_carving_decrease_height_helper(inputSeamCarvingPrague, energy_img_prague, pixel_);
end

function [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_height_helper(inputImg, energyImg, pixel)
    if(pixel == 0)
        reducedImg = inputImg;
        reducedEnergyImg = energyImg; 
        pixelReduced = pixel;
        return
    else
        pixel = pixel-1;
        % imagesc(inputImg);
        % drawnow();
        [reducedImg_, reducedEnergyImg_] = decrease_height(inputImg, energyImg);
        [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_height_helper(reducedImg_, reducedEnergyImg_, pixel);
    end
end

function inputSeamCarvingPragueReduced = seam_carving_decrease_width(pixel_, im)
    pixel_to_reduce = pixel_;
    inputSeamCarvingPrague = im;
    energy_img_prague = energy_img(inputSeamCarvingPrague);
    [inputSeamCarvingPragueReduced,~,pixelReduced] = seam_carving_decrease_width_helper(inputSeamCarvingPrague, energy_img_prague, pixel_);
end

function [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_width_helper(inputImg, energyImg, pixel)
    if(pixel == 0)
        reducedImg = inputImg;
        reducedEnergyImg = energyImg; 
        pixelReduced = pixel;
        return
    else
        pixel = pixel-1;
        %imagesc(inputImg);
        %drawnow();
        [reducedImg_, reducedEnergyImg_] = decrease_width(inputImg, energyImg);
        [reducedImg, reducedEnergyImg, pixelReduced] = seam_carving_decrease_width_helper(reducedImg_, reducedEnergyImg_, pixel);
    end
end