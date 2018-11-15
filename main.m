%Game: int
game = 1;

for i = 1 : length(dir(strcat('assets/original/', int2str(game), '_*.jpg')))
    threshold(game,i,0.5)
end

