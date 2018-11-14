%Threshold 0-1
threshold = 0.5;

nrOfGames = length(dir(strcat('assets/original/', '*_1.jpg')));
for j = 1 : nrOfGames
    nrOfRounds = length(dir(strcat('assets/original/', int2str(j), '_*.jpg')));
    for i = 1 : nrOfRounds
        nr = int2str(i);
        filename = strcat(int2str(j), '_', nr, '.jpg');
        img = im2double((imread( strcat('assets/original/',filename))));
        BW = im2bw(img,threshold);
        imwrite(BW, fullfile('assets/threshold/', strcat('T', filename)));
    end
end