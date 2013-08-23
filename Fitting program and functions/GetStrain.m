% Function to get the strain magnitude and directions.
% angle is angle to 100 direction.
function Strain = GetStrain(magnitude, angle)
Strain.magnitude = magnitude;
Strain.angle = angle*(pi/180);

% Direction cosines of strain
Strain.beta1 = cos(Strain.angle);
Strain.beta2 = cos(pi/2 - Strain.angle);
end