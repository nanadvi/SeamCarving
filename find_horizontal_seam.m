function horizontalSeam = find_horizontal_seam(cumulativeEnergyMap)
    % Transpose the image
    horizontalSeam = seamHelper(cumulativeEnergyMap')';
    
function seam = seamHelper(map)
    [row,col] = size(map);
    seam = zeros(row,1);
    % Minimum value and index of the last row
    [~, index] = min(map(row, :));
    seam(row) = index;
    last = index;
    % go to the last row and go backwards
    for i = row-1:-1:1
        if(i==1)
            %last row
            last = seam(2);
            switch last
                case 1
                    [~, index] = min([map(i,last), map(i, last+1)]);
                    if(index == 2)
                        last = last + 1 ;
                    end
                case col                      
                    [~, index] = min([map(i,last), map(i, last-1)]);
                    %move diagonally up
                    if(index == 2)
                        last = last - 1 ;
                    end
                otherwise
                    [~, index] = min([map(i,last-1), map(i, last) ,map(i, last+1)]);
                    switch index
                        case 2
                            %Diagonal left
                            last = last - 1;
                        case 3
                            %Diagonal right
                            last = last+1;
                    end
            end
            seam(1) = last;
        else
            switch last
                %consider only top and right
                case 1
                    [~, index] = min([map(i-1,last), map(i-1, last+1)]);
                    %move diagonally up
                    if(index == 2)
                        last = last + 1 ;
                    end
                %consider only top and left
                case col
                    [~, index] = min([map(i-1,last), map(i-1, last-1)]);
                    %move diagonally up
                    if(index == 2)
                        last = last - 1 ;
                    end
                % Default
                otherwise
                    [~, index] = min([map(i-1,last-1), map(i-1, last) ,map(i-1, last+1)]);
                    switch index
                        case 1
                            %Diagonal left
                            last = last - 1;
                        case 3
                            %Diagonal right
                            last = last+1;
                    end
            end
        end
        seam(i) = last;
    end