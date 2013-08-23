% This function reshapes the 1D arrays of field and magnetisation angle into
% two matrices of the same size.
% This allows the the two matrices to be multiplied together element-wise.
function [HMatrix AngleMatrix] = EnergyArray(Field, AngleArray)
HMatrix = repmat(Field, [size(AngleArray,2) 1 1]);
AngleMatrix = repmat(AngleArray(:), [1 size(HMatrix,2) 1]);

end