function occ = countOccurences(score)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
occ = [nnz(score==1),nnz(score==2)];
end

