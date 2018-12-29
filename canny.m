function return_value = canny(gameNr, roundNr)
    f = filename(gameNr, roundNr);
    img = imread(['assets/geometric_transformation/G' f]);

    %img = imbinarize(img);
    img = rgb2gray(img);
    img = im2double(img);
    
    sMatY = [1, 2, 1; 0, 0, 0; -1, -2, -1];
    sMatX = [-1, 0 , 1; -2, 0 , 2; -1, 0, 1];
    sX = imfilter(img, sMatX);
    sY = imfilter(img, sMatY);
    

    
    % Calculate gradient
    gradient = sqrt(sX.^2 + sY.^2);
    
    % Calculate direction
    thetha = rad2deg(atan2(sX, sY));    
    %thetha = rad2deg(atan(sY ./ sX));

    % Rounding angles
    for i = 1:500
        for j = 1:500
                      
            if thetha(i,j) < 22.5 && thetha(i,j) > -22.5 || thetha(i,j) > 157.5 || thetha(i,j) < -157.5
				thetha(i,j) = 0;
                
			elseif thetha(i,j) > 22.5 && thetha(i,j) < 67.5 || thetha(i,j) < -112.5 && thetha(i,j) > -157.5
				thetha(i,j) = 45;
                
			elseif thetha(i,j) > 67.5 && thetha(i,j) < 112.5 || thetha(i,j) < -67.5 && thetha(i,j) > -112.5
				thetha(i,j) = 90;
                
			elseif thetha(i,j) > 112.5 && thetha(i,j) < 157.5 || thetha(i,j) < -22.5 && thetha(i,j) > -67.5
				thetha(i,j) = 135;
            end
        end
    end
   
    % Thresholding
    
    gradientMax = max(max(gradient));
    gradientMin = min(min(gradient));
    level = 0.25 * (gradientMax - gradientMin) + gradientMin;
    
    temp = max(gradient, level .* ones(size(gradient)));

    imshow(edge(img, 'canny'));
    
    
    % Non-maximum suppression
     
    %gradient = imhmax(gradient, max(max(gradient))/4, 8);
    
    %imshow(imbinarize(gradient, 0.99))
    %imshow(gradient)
    
   
    
    return_value = 1;
end