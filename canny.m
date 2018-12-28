function return_value = canny(gameNr, roundNr)
    f = filename(gameNr, roundNr);
    img = imread(['assets/geometric_transformation/G' f]);

    %img = imbinarize(img);
    
    sMatY = [1, 2, 1; 0, 0, 0; -1, -2, -1]
    sMatX = [-1, 0 , 1; -2, 0 , 2; -1, 0, 1]
    sX = imfilter(img, sMatX);
    sY = imfilter(img, sMatY);
    
    thetha = atan(sY ./ sX);
    
    %sobel = sqrt(imfilter(img, sX).^2 + imfilter(img, sY).^2);
    
    imshow(sobel);
    
    return_value = 1;
end