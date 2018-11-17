function return_value = canny(gameNr, roundNr)
    return_value = 1;
    
    f = filename(gameNr, roundNr);
    
    
    img = imread(['assets/geometric_transformation/G' f]);
    
    im = imdilate(img,strel('disk',2));
    BW = imerode(im,strel('disk',2));
    BW = edge(BW,'Canny');

    imshow(BW);
end