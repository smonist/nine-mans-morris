function geometric_transformation(gameNr, roundNr, corners)
    f = filename(gameNr, roundNr);
    img = imread(['assets/threshold/T' f]);

    base = [0 506; 506 506; 506 0; 0 0];
    tf = fitgeotrans(corners,base,'projective');
    
    [xf1, xf1_ref] = imwarp(img,tf);
    [xdataT,ydataT] = transformPointsForward(tf,corners(1:4),corners(5:8));
    [xdataI, ydataI] = worldToIntrinsic(xf1_ref,xdataT,ydataT);
    
    croped = imcrop(xf1,[min(xdataI)+4 min(ydataI)+4 499 499]);
    croped = imrotate(croped, 180);
    imwrite(croped, fullfile('assets/geometric_transformation/', ['G', f]));
end