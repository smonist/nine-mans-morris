%game: int
game = 3;

%threshold: float <= 1 && >= 0
custom_threshold = 0.5;

for i = 2 : length(dir(strcat('assets/original/', int2str(game), '_*.jpg')))
    corners = threshold(game,i,custom_threshold);
    geometric_transformation(game, i, corners);
    canny(game, i);
    hough(game, i); 
    score = findStein(game, i);
    score 
end
