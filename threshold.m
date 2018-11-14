%nrOfGames:
%int. converts all rounds of chosen game into B&W images. if 0
%converts all images in /assets/original 
%
%nrOfRound:
%int. converts chosen round of chosen game into B&W images. if 0 converts all rounds of
%chosen game
%
%custom_threshold:
%threshold between 1 and 0
function a = threshold(nrOfGames, nrOfRound ,custom_threshold)
    if(nrOfGames == 0)
        nrOfGames = length(dir(strcat('assets/original/', '*_1.jpg')));
    end
    for j = 1 : nrOfGames
        if(nrOfRound == 0)
            nrOfRound = length(dir(strcat('assets/original/', int2str(j), '_*.jpg')))
        end
        for i = 1 : nrOfRound
            nr = int2str(i);
            filename = strcat(int2str(j), '_', nr, '.jpg');
            
            BW = imread( strcat('assets/original/',filename));
            BW = rgb2gray(BW);
            BW = imbinarize(BW, custom_threshold);
            
            %find first horizontal pixel
            [x, y] = find(BW, 1, 'first');
            
            imagesc(rot90(flipud(BW),-1))
            set(gca,'YDir','normal')
            rectangle('Position', [x, y, 100, 100], 'FaceColor',[1 0 0 ])
            
            
            %find first vertical pixel
            %[x, y] = find(BW, 1, 'first')

            
            %imwrite(BW, fullfile('assets/threshold/', strcat('T', filename)));
        end
    end
end