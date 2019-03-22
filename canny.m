function canny(gameNr, roundNr)
    %IMPORTANT LEGAL NOTICE
    %.----------------.
    %|                |
    %|      /||\      |
    %|     /_||_\     |
    %| =m==========m= |
    %|   /   ||   \   |
    %|  /____||____\  |
    %|                |
    %'----------------'


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
    theta = rad2deg(atan2(sX, sY));    
    %theta = rad2deg(atan(sY ./ sX));

    % Rounding angles
    for i = 1:500
        for j = 1:500
                      
            if theta(i,j) < 22.5 && theta(i,j) > -22.5 || theta(i,j) > 157.5 || theta(i,j) < -157.5
				theta(i,j) = 0;
                
			elseif theta(i,j) > 22.5 && theta(i,j) < 67.5 || theta(i,j) < -112.5 && theta(i,j) > -157.5
				theta(i,j) = 45;
                
			elseif theta(i,j) > 67.5 && theta(i,j) < 112.5 || theta(i,j) < -67.5 && theta(i,j) > -112.5
				theta(i,j) = 90;
                
			elseif theta(i,j) > 112.5 && theta(i,j) < 157.5 || theta(i,j) < -22.5 && theta(i,j) > -67.5
				theta(i,j) = 135;
            end
        end
    end
   
    % Thresholding
    gradientMax = max(max(gradient));
    gradientMin = min(min(gradient));
    level = 0.25 * (gradientMax - gradientMin) + gradientMin;
    ibw = max(gradient, level .* ones(size(gradient)));
    
    
    
    %NON MAX WUUUUUUUUUUUUUUUUT
    I_temp = zeros(size(ibw, 1), size(ibw, 2));
    [n,m] = size(ibw);
    for i = 2:n - 1,
        for j = 2:m - 1,
            switch theta(i, j)
                %horizontal edge = vertical filter
                case 0
                    I_temp(i, j) = (gradient(i, j) == max([gradient(i, j), gradient(i, j + 1), gradient(i, j - 1)]));
                    
                %diagonal edge = diagonal filter 
                case 45
                    I_temp(i, j) = (gradient(i, j) == max([gradient(i, j), gradient(i + 1, j - 1), gradient(i - 1, j + 1)]));
                
                %vertical edge = horizontal filter 
                case 90
                    I_temp(i, j) = (gradient(i, j) == max([gradient(i, j), gradient(i + 1, j), gradient(i - 1, j)]));
                
                %diagonal edge = diagonal filter 
                case 135
                    I_temp(i, j) = (gradient(i, j) == max([gradient(i, j), gradient(i + 1, j + 1), gradient(i - 1, j - 1)]));
            end
        end
    end
    
    I_temp = I_temp .* gradient;
    
    
    
    
    %{
    % Thinning
    [n,m]=size(ibw);
    for i=2:n-1,
        for j=2:m-1,
            if ibw(i,j) > level,
            X = [-1, 0, +1;
                -1, 0, +1;
                -1, 0, +1];
            Y = [-1, -1, -1;
                0, 0, 0;
                +1, +1, +1];
            Z = [ibw(i-1,j-1), ibw(i-1,j), ibw(i-1,j+1);
               ibw(i,j-1), ibw(i,j), ibw(i,j+1);
               ibw(i+1,j-1), ibw(i+1,j), ibw(i+1,j+1)];
            XI = [sX(i,j)/gradient(i,j), -sX(i,j)/gradient(i,j)];
            YI = [sY(i,j)/gradient(i,j), -sY(i,j)/gradient(i,j)];
            ZI = interp2(X, Y, Z, XI, YI);
                if ibw(i,j) >= ZI(1) & ibw(i,j) >= ZI(2)
                    I_temp(i,j)=gradientMax;
                else
                    I_temp(i,j)=gradientMin;
                end
            else
            I_temp(i,j) = gradientMin;
            end
        end
    end

    %}
    
    imshow(I_temp);
    
    
    % Non-maximum suppression
     
    %gradient = imhmax(gradient, max(max(gradient))/4, 8);
    

    for i=1:499
        for j = 1:499
            if (I_temp(i,j) > 2) 
                I_temp(i,j) = 1; 
            end 
        end 
    end 
    %imshow(I_temp) 
    imwrite(I_temp, fullfile('assets/Canny/', ['E', f]));
end