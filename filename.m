function f = filename(gameNr, roundNr, folder)
    if~exist('folder','var')
      f = [int2str(gameNr) '_' int2str(roundNr) '.jpg'];    
    else
      f = ['assets/' folder, '/' int2str(gameNr) '_', int2str(roundNr) '.jpg'];
    end
end