function cumulativeEnergyMap = cumulative_min_energy_map(energyImg,seamDirection)
    switch seamDirection
        case 'HORIZONTAL'
            temp = cumulative_min_energy_map_helper(energyImg');
            cumulativeEnergyMap = temp';
        case 'VERTICAL'
            cumulativeEnergyMap = cumulative_min_energy_map_helper(energyImg);
    end

function map = cumulative_min_energy_map_helper(energyImg)
    [row, col] = size(energyImg);
    map = energyImg;
    for x = 2:row
        for y = 1:col
            % First column; only check up and right
            if (y==1)
                map(x,y) = energyImg(x,y) + min([map(x-1, y), map(x-1, y+1)]);
            % Last column; only check last and last-1
            elseif (y == col)
                map(x,y) = energyImg(x,y) + min([map(x-1, y), map(x-1, y-1)]);
            else 
                map(x,y) = energyImg(x,y) + min([map(x-1, y-1), map(x-1, y), map(x-1, y+1)]);
            end
        end
    end