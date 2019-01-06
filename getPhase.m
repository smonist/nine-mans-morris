function gamePhase = getPhase(scorePrev, score)
gamePhase = true;
counterBefore = 0;
counterAfter = 0;

pic1_1 = [scorePrev(1,1,1), scorePrev(1,2,1), scorePrev(1,3,1), scorePrev(2,3,1), scorePrev(3,3,1), scorePrev(3,2,1), scorePrev(3,1,1), scorePrev(2,1,1)];
pic1_2 = [scorePrev(1,1,2), scorePrev(1,2,2), scorePrev(1,3,2), scorePrev(2,3,2), scorePrev(3,3,2), scorePrev(3,2,2), scorePrev(3,1,2), scorePrev(2,1,2)];
pic1_3 = [scorePrev(1,1,3), scorePrev(1,2,3), scorePrev(1,3,3), scorePrev(2,3,3), scorePrev(3,3,3), scorePrev(3,2,3), scorePrev(3,1,3), scorePrev(2,1,3)];

pic2_1 = [score(1,1,1), score(1,2,1), score(1,3,1), score(2,3,1), score(3,3,1), score(3,2,1), score(3,1,1), score(2,1,1)];
pic2_2 = [score(1,1,2), score(1,2,2), score(1,3,2), score(2,3,2), score(3,3,2), score(3,2,2), score(3,1,2), score(2,1,2)];
pic2_3 = [score(1,1,3), score(1,2,3), score(1,3,3), score(2,3,3), score(3,3,3), score(3,2,3), score(3,1,3), score(2,1,3)];

for i = 1:8
    if pic1_1(i) ~= 0
        counterBefore = counterBefore +1;
    end
    if pic1_2(i) ~= 0
        counterBefore = counterBefore +1;
    end
    if pic1_3(i) ~= 0
        counterBefore = counterBefore +1;
    end
    
     if pic2_1(i) ~= 0
        counterAfter = counterAfter +1;
    end
    if pic2_2(i) ~= 0
        counterAfter = counterAfter +1;
    end
    if pic2_3(i) ~= 0
        counterAfter = counterAfter +1;
    end
end

if counterAfter > counterBefore
    gamePhase = false;
elseif counterAfter == counterBefore && checkForMill(score) && ~checkForMill(scorePrev)
    gamePhase = false;
end

end

