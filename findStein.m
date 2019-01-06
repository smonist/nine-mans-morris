function matrix = findStein(gameNr, roundNr, centers)

    ft = filenameText(gameNr, roundNr);
    %centers = dlmread(fullfile('assets/Hough/', ['HT', ft]));
    centersize = size(centers);
    
    % if file is not emty
    if centersize(1) ~= 0 
        f = filename(gameNr, roundNr);
        img = imread(['assets/geometric_transformation/G' f]);
        img = rgb2gray(img); 
        imshow(img); 

        maxdist = 25;   %kleinste distanze zwischen zwei feldern ist 60 pixel 

        Middles = [ 50 50 ; 50 250; 50 450;         250 450; 450 450; 450 250;      450 50 ; 250 50 ;
                    110 105; 110 250; 110,400;      250,400 ; 390,400 ; 390,250;    390,110 ; 250,110;
                    180, 180 ; 180,250 ; 180,310;   250,315 ; 310,315 ;310,250;     310, 180 ; 250,180];

        stones = zeros(1, 24);

        for j = 1:centersize(1)
            for i = 1 : 24
            dist = distance(Middles(i,:),centers(j, :));
                if dist <= maxdist
                    stones(i)= checkColor(img, centers(j, :));
                end
            end
        end

       matrix = stonesTo333(stones);    
     else
        % keine spiele am feld da fileemty -> leere matrix �bergeben
        matrix = zeros(3,3,3);

    end
    
    dlmwrite(fullfile('assets/score/', ['M', ft]),matrix);

end

function [d] = distance(p1, p2)
       yd = abs(p1(1) - p2(1)); 
       xd = abs(p1(2) - p2(2)); 
       d = sqrt(yd*yd + xd*xd);  
end 

function color = checkColor(img , center)

    colorImage = img(center(1), center(2));
    offset = 5;
    %oben und unten u recht u links eins
    up = img(center(1)+offset, center(2));
    down =img(center(1)-offset, center(2));
    right =img(center(1), center(2)+offset);
    left = img(center(1), center(2)-offset);
     
    avergaC = uint16(uint16(colorImage) + uint16(up) + uint16(down) + uint16(right) + uint16(left));
    avergaC = avergaC / 5;
    if(avergaC < 80) 
        color = 1;  
     else
         if (avergaC > 180)
            color = 2; 
         else
              color = 3; 
         end 
     end 

end

function matrix = stonesTo333(stones)
   matrix = zeros(3,3,3);
    for i=1:3
        matrix(1,1,i)=stones(1+(i-1)*8);
        matrix(1,2,i)=stones(2+(i-1)*8);
        matrix(1,3,i)=stones(3+(i-1)*8);
        matrix(2,3,i)=stones(4+(i-1)*8);
        matrix(3,3,i)=stones(5+(i-1)*8);
        matrix(3,2,i)=stones(6+(i-1)*8);
        matrix(3,1,i)=stones(7+(i-1)*8);
        matrix(2,1,i)=stones(8+(i-1)*8);
    end
  
end