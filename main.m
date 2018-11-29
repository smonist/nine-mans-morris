%Game: int
game = 1;

for i = 1 : length(dir(strcat('assets/original/', int2str(game), '_*.jpg')))
    corners = threshold(game,i,0.5);
    geometric_transformation(game, i, corners);
end

