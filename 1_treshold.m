gameNr = int2str(1);
myfile=dir(strcat('assets/original/', gameNr, '_*.jpg')); 
numFiles = length(myfile);

for i = 1 : numFiles
nr = int2str(i);
filename = strcat(gameNr, '_', nr, '.jpg');
img = im2double((imread( strcat('assets/original/',filename))));
BW = im2bw(img,0.5);
imwrite(BW, fullfile('assets/threshold/', strcat('T', filename)));
end