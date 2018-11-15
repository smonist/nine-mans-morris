function v = threshold(gameNr, roundNr, custom_threshold)
    f = filename(gameNr, roundNr);
    
    BW = imread(['assets/original/' f]);
    BW = rgb2gray(BW);
    BW = imbinarize(BW, custom_threshold);

    %vertices matrix
    v = zeros(2,4);

    %bottom left
    v(1) = 0;
    v(2) = 0;
    %top left
    [v(4), v(3)] = find(BW, 1, 'first');
    %top right
    v(5) = 0;
    v(6) = 0;
    %bottom right
    [v(8), v(7)] = find(BW, 1, 'last');

    
    %print rectangle
    imshow(BW);
    hold on
    plot(v(1:2:8),v(2:2:8),'r','Linewidth',2);
    hold off;
    %end print
    
    
    imwrite(BW, fullfile('assets/threshold/', ['T', f]));
end