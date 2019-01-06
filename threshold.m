function corners = threshold(gameNr, roundNr, custom_threshold)
    f = filename(gameNr, roundNr);
    
    BW = imread(['assets/original/' f]);
    BW = rgb2gray(BW);
    BW = imbinarize(BW, custom_threshold);
    se = strel('cube',4);
    BW = imerode(BW,se);

    % Find vertices
    
    [Ys,Xs] = find(BW);
    
    [temp,temp] = min(Ys+Xs);
    
    % Corner 1
    corners = [Xs(temp),Ys(temp)];
    [temp,temp] = min(Ys-Xs);
    
    % Corner 2
    corners(2,:) = [Xs(temp),Ys(temp)];
    [temp,temp] = max(Ys+Xs);
    
    % Corner 3
    corners(3,:) = [Xs(temp),Ys(temp)];
    [temp,temp] = max(Ys-Xs);

    % Corner 4
    corners(4,:) = [Xs(temp),Ys(temp)];
 
    %figure, imshow(BW); hold all
    %plot(NON_ZERO([1:4 1],1), NON_ZERO([1:4 1],2),'r','linewidth',3);

    imwrite(BW, fullfile('assets/threshold/', ['T', f]));
end