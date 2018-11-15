function f = filename(gameNr, roundNr, folder)
    if~exist('folder','var')
      f = strcat(int2str(gameNr), '_', int2str(roundNr), '.jpg');      
    else
      f = strcat('assets/', folder, '/', int2str(gameNr), '_', int2str(roundNr), '.jpg');
    end
end