function findStein(gameNr, roundNr)

    ft = filenameText(gameNr, roundNr);
    centers = dlmread(fullfile('assets/Hough/', ['HT', ft]));
    centersize = size(centers);
    
    f = filename(gameNr, roundNr);
    img = imread(['assets/geometric_transformation/G' f]);
    img = img2gray(img); 
    colorImage = img(center); 
    
    maxdist = 30;
    %find sector    
    % links oben nach rechts
    % outer
    % 33,33 // 25,250 // 25,470 // 245,470 // 465,470 // 465,255 // 470,34
    % // 250, 32 // 
    % middle
    % 107,107 // 250,100 // 100,396 // 245,397 // 393,297 // 393,255 //
    % 392,108 // 249,107 // 
    %smalll
    % 175, 180 // 175,250 // 175, 323 // 245,323 // 316,324 // 320,255 //
    % 320, 180 // 246,180
     
    Middles = [ 33 33 ; 25 250; 25 470; 245 470; 465 470; 465 255; 270 34 ; 250 32 ;
                107 107; 250 100; 100,396 ; 245,397 ; 393,297 ; 393,255 ; 392,108 ; 249,107;
                175, 180 ; 175,250 ; 175, 323 ; 245,323 ; 316,324 ; 320,255 ; 320, 180 ; 246,180 ];
    
    stones = zeros(24);
    
    for j = 1:centersize(1)
        for i = 1 : 24
        dist = distance(Middles(i,:),centers(j, :))
            if dist <= maxdist
                stones(i)= checkColor(colorImage, centers(j, :));
            end
        end
    
    end

    stones
    
end

function [d] = distance(p1, p2)
       yd = abs(p1(1) - p2(1)); 
       xd = abs(p1(2) - p2(2)); 
       d = sqrt(yd*yd + xd*xd);  
end 

function color = checkColor(img , center)

    colorImage = img(center); 
     if(colorImage < 125) 
        color = 1; 
     else
         color = 2; 
     end 

end