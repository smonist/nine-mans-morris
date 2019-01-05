function storeScore(gameNr, roundNr, score)
   
    ft = filenameScore(gameNr);
      
    if roundNr == 1 
        fid = fopen(fullfile('assets/out/', ['M', ft]),'wt');
        fprintf(fid, '  **** nine-mans-morris **** \n \n  Game Nr.: %d \n \n', gameNr);
        fclose(fid);
    else
        stones= matrixToscore(score);
        fid = fopen(fullfile('assets/out/', ['M', ft]),'a+');
        fprintf(fid, '  ----------------------- \n  **** Round Nr.: %d **** \n \n ', roundNr);
        fprintf(fid,    '  %c --------- %c --------- %c \n   |           |           | \n   |    %c------%c-------%c   | \n   |    |      |       |   | \n   |    |   %c--%c--%c    |   | \n   |    |   |  |  |    |   | \n   %c----%c---%c-----%c----%c---%c \n   |    |   |  |  |    |   | \n   |    |   %c--%c--%c    |   | \n   |    |      |       |   | \n   |    %c------%c-------%c   | \n   |           |           | \n   %c --------- %c --------- %c \n \n', stones);
        
        fclose(fid);
    end

end

function stones = matrixToscore(matrix)
   stones = zeros(1,24);
        stones(1)=matrix(1,1,3);
        stones(2)=matrix(1,2,3);
        stones(3)=matrix(1,3,3);
        stones(4)=matrix(1,1,2);
        stones(5)=matrix(1,2,2);
        stones(6)=matrix(1,3,2);
        stones(7)=matrix(1,1,1);
        stones(8)=matrix(1,2,1);
        stones(9)=matrix(1,3,1);
        stones(10)=matrix(2,1,3);
        stones(11)=matrix(2,1,2);
        stones(12)=matrix(2,1,1);
        stones(13)=matrix(2,3,1);
        stones(14)=matrix(2,3,2);
        stones(15)=matrix(2,3,3);
        stones(16)=matrix(3,1,1);
        stones(17)=matrix(3,2,1);
        stones(18)=matrix(3,3,1);
        stones(19)=matrix(3,1,2);
        stones(20)=matrix(3,2,2);
        stones(21)=matrix(3,3,2);
        stones(22)=matrix(3,1,3);
        stones(23)=matrix(3,2,3);
        stones(24)=matrix(3,3,3);
        
        for i = 1:24
            if stones(i) == 1
                stones(i) = 'B';
            elseif stones(i) == 2
                stones(i) = 'W';
            else
                stones(i) = '+';
            end
                
        end
             
                
        
end