% [Energy]  = CubicAnisEnergy(Kc, MagAngle,offset)
% Function to calculate the cubic anisotropy energy contribution.
% Inputs are the cubic anisotropy coeffient and angle, the angle between
% the magnetisation direction and the orthogonal axes formed by the
% crystal lattice.
% This equation assumes theta measured from uniaxial easy axis direction,
% so offset angle is introduced to make angles measured from [100]
% direction.
% See Garcia-Otero et al.(1999)
function [Energy]  = CubicAnisEnergy(Kc, MagAngle,offset)
Energy = -(Kc/4)*(sin(2*(MagAngle+offset))).^2;
end