function [center] = hough(gameNr, roundNr, radiusMin, radiusMax)
    f = filename(gameNr, roundNr);
    ft = filenameText(gameNr, roundNr); 
    intersect = 35; 
    border = 13;  
    
    img = imread(['assets/Canny/E' f]);
    img = imbinarize(img); 

    center = [1000,1000];   %Matrix which stores all potential midpoints. 
    for i=radiusMin:radiusMax
        centertmp = hufffixedRadius(i,img,intersect, border);
        center = [center;centertmp]; %adds another midpoints to the Matrix. 
    end 
    center = deletDouble(center, radiusMin); %delets all midpoints which are close together. 
    center(1,:) = [];
    
    centerBin = zeros(500,500); %creates an Matrix which stores the midpoints position on the matchfield 
    
    for i=1:size(center,1)
        tmpY = center(i,1); 
        tmpX = center(i,2);
        centerBin(tmpY, tmpX) = 1; 
    end 
    imwrite(centerBin, fullfile('assets/Hough/', ['H', f]));
    dlmwrite(fullfile('assets/Hough/', ['HT', ft]),center);
end 


function [center] = hufffixedRadius(radius, edge, intersect, border) 
    [rows, columns] = size(edge);
    step = pi*2/intersect;
    huff = zeros(500, 500); 
    if (border > 0) 
        for y=1:rows
            for x=1:columns
               if(edge(y,x) == 1)
                   for t = 0:step:(pi*2)
                        hx = int16(x + radius * cos(t));
                        hy = int16(y + radius *  sin(t));
                        if (hx < 500 && hx > 0)
                            if (hy > 0 && hy < 500)
                               huff(hy,hx) = huff(hy,hx)+1;
                            end 
                        end 
                   end 
               end 
            end
        end
      
        center = [10000,100000]; 
        for y=1:rows
            for x=1:columns
                if(huff(y,x) >= border) %wenn punkt wert hoch genug ist als Mittelpunkt hinzufügen
                    center = [center;y x];
                end 
            end 
        end 
        
        center = deletDouble(center, radius); %lösche alle Mittelpunkte die zu nah zusammen sind
        center(1,:) = [];   
    end 
    
end 


% löscht punkte die zu nah zusammen sind (distance < radius) weil wir
% annnehmen das 2 kreise nie übereinander liegen. 
function [center] = deletDouble(center,radius) 
    [rowsCenter, columnsCenter] = size(center);
    i=1;
    while(i < rowsCenter)
            j = i+1; 
            while(j <= rowsCenter) 
                        d = distance(center(i,:), center(j,:));
                        if (d < radius) %kreise überlappen sich 
                            center(i,:) = [];   %löscht den ersten.
                            i = i-1;
                            j = j-1; 
                            rowsCenter = rowsCenter-1;
                        end 
                j = j+1;
            end
        i = i+1; 
    end
end 


%calculates the distance between two points 
function [d] = distance(p1, p2)
       yd = abs(p1(1) - p2(1)); 
       xd = abs(p1(2) - p2(2)); 
       d = sqrt(yd*yd + xd*xd);  
end 


