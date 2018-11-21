function corners = threshold(gameNr, roundNr, custom_threshold)
    f = filename(gameNr, roundNr);
    
    BW = imread(['assets/original/' f]);
    BW = rgb2gray(BW);
    BW = imbinarize(BW, custom_threshold);
    se = strel('cube',4);
    BW = imerode(BW,se);

    %vertices matrix
    
    [ALL_Y,ALL_X] = find(BW);
    [~,found] = min(ALL_Y+ALL_X);

    corners = [ALL_X(found),ALL_Y(found)];
    [~,found] = min(ALL_Y-ALL_X);

    corners(2,:) = [ALL_X(found),ALL_Y(found)];
    [~,found] = max(ALL_Y+ALL_X);

    corners(3,:) = [ALL_X(found),ALL_Y(found)];
    [~,found] = max(ALL_Y-ALL_X);

    corners(4,:) = [ALL_X(found),ALL_Y(found)];
 
    %figure, imshow(BW); hold all
    %plot(NON_ZERO([1:4 1],1), NON_ZERO([1:4 1],2),'r','linewidth',3);

    imwrite(BW, fullfile('assets/threshold/', ['T', f]));
end