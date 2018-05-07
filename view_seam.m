function view_seam(im,seam,seamDirection)
    [dim1, dim2, ~] = size(im); 
    switch seamDirection
        case 'HORIZONTAL'
            for i=1:dim2
                id = seam(i);
                im(id,i,1) = 255;
                im(id,i,2) = 0;
                im(id,i,3) = 0;
            end
            imagesc(im); 
        case 'VERTICAL'
            for i=1:dim1        
                id = seam(i);
                im(i,id,1) = 255;
                im(i,id,2) = 0;
                im(i,id,3) = 0;
            end
            imagesc(im); 
    end