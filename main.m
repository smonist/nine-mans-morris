%game: int
game = 1;

%threshold: float <= 1 && >= 0
custom_threshold = 0.5;

for i = 1 : length(dir(strcat('assets/original/', int2str(game), '_*.jpg')))
    corners = threshold(game,i,custom_threshold);
    geometric_transformation(game, i, corners);
    canny(game, i);
    if (game == 3 || game == 4) 
        centerPoints = hough(game, i, 15,25,35,0.3); %durchschnittlicher radius der Kreise im entzerrten Bild = 20px
    else 
        centerPoints = hough(game, i, 15,25,35,0.37); %durchschnittlicher radius der Kreise im entzerrten Bild = 20px
    end 
    if i ~= 1
        prevScore = score;
    end
    score = findStein(game, i, centerPoints);
    storeScore(game, i, score);
    if i ~= 1
        isLegit(prevScore, score, i);
    end
    score
end