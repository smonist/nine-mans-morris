function corners = threshold(gameNr, roundNr, custom_threshold)
    f = filename(gameNr, roundNr);
    
    BW = imread(['assets/original/' f]);
    BW = rgb2gray(BW);
    BW = imbinarize(BW, custom_threshold);

    %vertices matrix
    corners = zeros(4,2)

    %{
    %bottom left
    corners(5) = 0;
    corners(1) = 0;
    %top left
    [corners(6), corners(2)] = find(BW, 1, 'first');
    %top right
    corners(7) = 0;
    corners(3) = 0;
    %bottom right
    [corners(8), corners(4)] = find(BW, 1, 'last');
    %}
    
    xarr = any(BW, 1);
    yarr = any(BW, 2);
    
    corn = zeros(2, 4);
    corn(1, 1:4) = size(BW, 2) / 2;
    corn(2, 1:4) = size(BW, 1) / 2;
    
    BW = imdilate(BW, strel('cube',100));
    
    
    for x = 1:length(xarr)
        if (xarr(1, x) == 1)
           for y = 1:length(yarr)
               if (BW(y, x) == 1)
                   if (x <= corn(1, 1) && y <= corn(2,1))
                      corn(:, 1) = [x, y];
                   end
                   
                   if (x >= corn(1, 2) && y <= corn(2,2))
                      corn(:, 2) = [x, y];
                   end
                   
                   if (x >= corn(1, 3) && y >= corn(2,3))
                      corn(:, 3) = [x, y];
                   end
                   
                   if (x <= corn(1, 4) && y >= corn(2,4))
                      corn(:, 4) = [x, y];
                   end
               end
           end
        end
    end
    
    corn
    
    %print rectangle
    figure, imshow(BW);
    hold on
    plot(corn(1, 1:4),corn(2, 1:4),'r','Linewidth',2);
    hold off;
    %end print
    
    
    imwrite(BW, fullfile('assets/threshold/', ['T', f]));
end