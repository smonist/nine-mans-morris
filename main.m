%Game: int
game = 3;

for i = 2 : length(dir(strcat('assets/original/', int2str(game), '_*.jpg')))
    corners = threshold(game,i,0.5);
    geometric_transformation(game, i, corners);
    canny(game, i);
    hough(game, i); 
    score = findStein(game, i);
    score 
end
