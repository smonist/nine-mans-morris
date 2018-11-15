function v = threshold(gameNr, roundNr, custom_threshold)
    filename = strcat(int2str(gameNr), '_', int2str(roundNr), '.jpg');

    BW = imread( strcat('assets/original/',filename));
    BW = rgb2gray(BW);
    BW = imbinarize(BW, custom_threshold);
    BW = imrotate(BW, -90);

    %vertices matrix
    v = zeros(2,4);

    %bottom left
    [v(2), v(1)];
    %top left
    [v(4), v(3)] = find(BW, 1, 'last');
    %top right
    [v(6), v(5)];
    %bottom right
    [v(8), v(7)] = find(BW, 1, 'first');
    
    
    %print rectangle
    imshow(BW);
    hold on;
    plot(v(1:2:8),v(2:2:8),'r','Linewidth',2);
    hold off;
    %end print
    
    imwrite(BW, fullfile('assets/threshold/', strcat('T', filename)));
end