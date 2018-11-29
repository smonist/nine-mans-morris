function return_value = canny(gameNr, roundNr)
    return_value = 1;
    f = filename(gameNr, roundNr);
    
    img = imread(['assets/geometric_transformation/G' f]);
    img = imbinarize(img, 0.9);
    img = imdilate(img,strel('disk',2));
    img = edge(img,'Canny');
    imwrite(img, fullfile('assets/Canny/', ['E', f]));
end