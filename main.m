%game: int
game = 1;

%threshold: float <= 1 && >= 0
custom_threshold = 0.5;

for i = 1 : length(dir(strcat('assets/original/', int2str(game), '_*.jpg')))
    corners = threshold(game,i,custom_threshold);
    geometric_transformation(game, i, corners);
    canny(game, i);
    centerPoints = hough(game, i, 15,25,35,0.37); %durchschnittlicher radius der Kreise im entzerrten Bild = 20px
    score = findStein(game, i, centerPoints);
    storeScore(game, i, score);
    score 
end

