function hough(gameNr, roundNr)
    f = filename(gameNr, roundNr);
    ft = filenameText(gameNr, roundNr); 
    radiusMin = 15; 
    radiusMax = 60; 
    intersect = 35; 
    border = 13;  
    
    img = imread(['assets/Canny/E' f]);
    img = imbinarize(img); 
    
    %img = imfinfo(['assets/Canny/E' f]);
    %img = imread('assets/testImages/coin.jpg');
    %img = rgb2gray(img); 
    %img = edge(img);
    
    
    center = [1000,1000]; %sollten wir uns sparen aber keine ahnung wie man das macht 
    for i=radiusMin:radiusMax
        centertmp = hufffixedRadius(i,img,intersect, border);
        center = [center;centertmp]; % fügt iterativ immer mehr Mittelpunkte hinzu
    end 
    center = deletDouble(center, radiusMin); %lösche alle Mittelpunkte die zu nah zusammen sind
    center(1,:) = []   %erste zeile wieder löschen 
    
    centerBin = zeros(500,500);
    for i=1:size(center,1)
        tmpY = center(i,1); 
        tmpX = center(i,2);
        centerBin(tmpY, tmpX) = 1; 
    end 
    imshow(centerBin); 
    imwrite(centerBin, fullfile('assets/Hough/', ['H', f]));
    dlmwrite(fullfile('assets/Hough/', ['HT', ft]),center);
end 



%berechnet den Mittelpunkt von den kreisen mit radius. 
%ende ->  kantenbild 
%intersect -> wie aus wie Punkten ein Kreis besteht (eher höherer Wert
%damit Geschlossen) 
% border -> wie viele KreisePunkte müssen im Huffraum übereinander liegen
%damit es als Kreismittelpunkt gezählt wird  

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
        %imshow(huff);   %kann man raus nehmen 

        center = [10000,100000]; %keine ahnung wie man das eleganter löst 
        for y=1:rows
            for x=1:columns
                if(huff(y,x) >= border) %wenn punkt wert hoch genug ist als Mittelpunkt hinzufügen
                    center = [center;y x];
                end 
            end 
        end 
        
        center = deletDouble(center, radius); %lösche alle Mittelpunkte die zu nah zusammen sind
        center(1,:) = [];   %lösche erste zeile. Sau schirch aber keine ahnung von dem Matlab dreck
    end 
    
end 



% löscht punkte die zu nah zusammen sind (distance < radius) weil wir
% annnehmen das 2 kreise nie übereinander liegen. Nimmt jetzt nur mal den 
% Löscht jetzt immer den vorderen Punkt raus & nicht immer den der im huff
% raum den geringsten wert hat
function [center] = deletDouble(center,radius) 
    [rowsCenter, columnsCenter] = size(center);
    i=1;
    while(i < rowsCenter)
            j = i+1; 
            while(j <= rowsCenter) 
                        d = distance(center(i,:), center(j,:));
                        if (d < radius) %kreise überlappen sich 
                            center(i,:) = [];   %löscht den ersten. Evtl zuerst schauen welcher der ist der im huff raum stärker ist 
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


