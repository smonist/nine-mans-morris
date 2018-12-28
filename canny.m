function return_value = canny(gameNr, roundNr)
    f = filename(gameNr, roundNr);
    img = imread(['assets/geometric_transformation/G' f]);
    
    img = imbinarize(img);
    
    imshow(img);
    
    return_value = 1;
end