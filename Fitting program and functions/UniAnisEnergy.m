% Energy = UniAnisEnergy(Ku, angle, offset)
% Function to calculate the unixaxial energy contribution.
% Inputs are the uniaxial anisotropy coefficient, Kc, and the angle, the
% angle between the magnetisation direction and the uniaxial easy axis.
% This equation assumes angle measured from uniaxial easy axis, so offset
% angle is introduced to make angles relative to [100] direction.
% Based on Stoner-Wohlfarth Model.
function Energy = UniAnisEnergy(Ku, angle, offset)
Energy = Ku * (sin(angle+offset)).^2;
end