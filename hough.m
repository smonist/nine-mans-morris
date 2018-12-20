
imput = imread('assets/testImages/circels10-50-55-60-100px.jpg');
imput = rgb2gray(imput);
imput = edge(imput);
imshow(imput); 
coin = imread('assets/testImages/coin.jpg');
coin = rgb2gray(coin); 
coin = edge(coin); 

%result = huff2d(25, imput, 30,10)
result3d = huff3d(5,50, imput, 50,22)       % alle treffen nie bei ca 40% funktioniert es meistens ganz gut
result3d = huff3d(35,50, coin, 50,22)       % alle treffen nie bei ca 40% funktioniert es meistens ganz gut


%berechnet den Mittelpunkt von kreisen mit einem radius radiusMin – radiusMax 
%ende ->  kantenbild 
%intersect -> wie aus wie Punkten ein Kreis besteht (eher höherer Wert
%damit Geschlossen) 
%border -> wie viele KreisePunkte müssen im Huffraum übereinander liegen
%damit es als Kreismittelpunkt gezählt wird 

function [center] = huff3d(radiusMin, radiusMax, edge, intersect, border)
    center = [1000,1000]; %sollten wir uns sparen aber keine ahnung wie man das macht 
    for i=radiusMin:radiusMax
        centertmp = huff2d(i,edge,intersect, border);
        center = [center;centertmp]; % fügt iterativ immer mehr Mittelpunkte hinzu
    end 
    center = deletDouble(center, radiusMin); %lösche alle Mittelpunkte die zu nah zusammen sind
    center(1,:) = [];   %erste zeile wieder löschen 
end 



%berechnet den Mittelpunkt von den kreisen mit radius. 
%ende ->  kantenbild 
%intersect -> wie aus wie Punkten ein Kreis besteht (eher höherer Wert
%damit Geschlossen) 
% border -> wie viele KreisePunkte müssen im Huffraum übereinander liegen
%damit es als Kreismittelpunkt gezählt wird  

function [center] = huff2d(radius, edge, intersect, border) 
    [rows, columns] = size(edge);
    step = pi*2/intersect;
    huff = zeros(rows, columns); 
    if (border > 0) 
        for y=1:rows
            for x=1:columns
               if(edge(y,x) == 1)
                   for t = 0:step:(pi*2)
                        hx = int16(x + radius * cos(t));
                        hy = int16(y + radius *  sin(t));
                        if (hx <= 500 && hy >= 0)
                            if (hy >= 0 && hy <= 500)
                               huff(hy,hx) = huff(hy,hx)+1;
                            end 
                        end 
                   end 
               end 
            end
        end
        imshow(huff);   %kann man raus nehmen 

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


