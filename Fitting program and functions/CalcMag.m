% Magnetisation = CalcMag(Angle, Ms)
% This function simply calculates the magnetisation for a given applied
% field angle and magnetisation direction.
function Magnetisation = CalcMag(MagAngle, Ms)
Magnetisation = Ms*cos(MagAngle);
end