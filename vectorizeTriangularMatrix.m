function vectorData = vectorizeTriangularMatrix(data)
%% Vectorize a sFCStats lower triangular matrix exluding the diagonal
% Args:
%   data     - sFCStats matrix data to be vectorized
%   num      - subject number
%
% Examples:
%   vectorData = vectorizeTriangularMatrix(SubjStats(1).R)

len = length(data);
vectorData = [];
for i = 2:len
    vectorData = [vectorData data(i,1:i-1,1)];
end
