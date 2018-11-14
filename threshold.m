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
            img = im2double((imread( strcat('assets/original/',filename))));
            BW = im2bw(img, custom_threshold);
            imwrite(BW, fullfile('assets/threshold/', strcat('T', filename)));
        end
    end
end