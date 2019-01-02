%Game: int
game = 1;

for i = 3 : length(dir(strcat('assets/original/', int2str(game), '_*.jpg')))
    corners = threshold(game,i,0.5);
    geometric_transformation(game, i, corners);
    canny(game, i);
    hough(game, i); 
    findStein(game, i);
end
