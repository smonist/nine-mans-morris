function isMill = checkForMill(score)
pic2_1 = [score(1,1,1), score(1,2,1), score(1,3,1), score(2,3,1), score(3,3,1), score(3,2,1), score(3,1,1), score(2,1,1)];
pic2_2 = [score(1,1,2), score(1,2,2), score(1,3,2), score(2,3,2), score(3,3,2), score(3,2,2), score(3,1,2), score(2,1,2)];
pic2_3 = [score(1,1,3), score(1,2,3), score(1,3,3), score(2,3,3), score(3,3,3), score(3,2,3), score(3,1,3), score(2,1,3)];
occ = countOccurences(score);

    if occ(1) >= 3 || occ(2) >= 3
        for j = 1:8
            if pic2_1(j) ~= 0
                if mod(j,2) ~= 0
                    if pic2_1(j) == pic2_1(j+1) && pic2_1(j) == pic2_1(mod(j+2,8)+1)
                        isMill = true;
                        return
                    elseif pic2_1(j) == pic2_2(j) && pic2_1(j) == pic2_3(j)
                        isMill = true;
                        return
                    end
                end


            end
        end

        for j = 1:8
            if pic2_2(j) ~= 0 && mod(j,2) ~= 0
                if pic2_2(j) == pic2_2(j+1) && pic2_2(j) == pic2_2(mod(j+2,8)+1)
                    isMill = true;
                    return
                end
            end
        end

        for j = 1:8
            if pic2_3(j) ~= 0 && mod(j,2) ~= 0
                if pic2_3(j) == pic2_3(j+1) && pic2_3(j) == pic2_3(mod(j+2,8)+1)
                    isMill = true;
                    return
                end
            end
        end
    end
    
    isMill = false;
    return
       
end

