function corners = threshold(gameNr, roundNr, custom_threshold)
    f = filename(gameNr, roundNr);
    
    BW = imread(['assets/original/' f]);
    BW = rgb2gray(BW);
    BW = imbinarize(BW, custom_threshold);

    %vertices matrix
    corners = zeros(4,2)

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

    
    %print rectangle
    imshow(BW);
    hold on
    plot(corners(1:4),corners(5:8),'r','Linewidth',2);
    hold off;
    %end print
    
    
    imwrite(BW, fullfile('assets/threshold/', ['T', f]));
end