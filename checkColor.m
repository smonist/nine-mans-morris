%returns the color of the game stone. If black it returns 1.
%If white it returns 2; 
function color = checkColor(gameNr, roundNr, center)
     f = filename(gameNr, roundNr);
     img = imread(['assets/geometric_transformation/G' f]);
     img = img2gray(img)
     imshow(img); 
     colorImage = img(center); 
     if(colorImage < 125) 
        color = 1; 
     else
         color = 2; 
     end 
end 