function findStein(gameNr, roundNr)

    ft = filenameText(gameNr, roundNr);
    centers = dlmread(fullfile('assets/Hough/', ['HT', ft]));
    centersize = size(centers);
    
    f = filename(gameNr, roundNr);
    img = imread(['assets/geometric_transformation/G' f]);
    img = img2gray(img); 
    
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
    
    stones = zeros(1, 24);
    
    for j = 1:centersize(1)
        for i = 1 : 24
        dist = distance(Middles(i,:),centers(j, :))
            if dist <= maxdist
                stones(i)= checkColor(img, centers(j, :));
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

function matrix = stonesTo333(stones)
   matrix = zeros(3,3,3);
    for i=1:3
        matrix(i,1,1)=stones(1+(i-1)*8);
        matrix(i,1,2)=stones(2+(i-1)*8);
        matrix(i,1,3)=stones(3+(i-1)*8);
        matrix(i,2,3)=stones(4+(i-1)*8);
        matrix(i,3,3)=stones(5+(i-1)*8);
        matrix(i,3,2)=stones(6+(i-1)*8);
        matrix(i,3,1)=stones(7+(i-1)*8);
        matrix(i,2,1)=stones(8+(i-1)*8);
    end
   
end