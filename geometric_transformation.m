function geometric_transformation(gameNr, roundNr, corners)
    f = filename(gameNr, roundNr);
    
    img = imread(['assets/threshold/T' f]);

    %[c r p] = impixel;
    base = [0 10; 10 10; 10 0; 0 0];
    tf = fitgeotrans(corners,base*50,'projective');

    [xf1, xf1_ref] = imwarp(img,tf);
    imshow(xf1)
    xf1_ref
    xf1 = imrotate(xf1, 180);
    imwrite(xf1, fullfile('assets/geometric_transformation/', ['registered_', f]));
end