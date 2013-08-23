% Function to determine the energy due to applied strain.
% Takes inputs of theta_mag, the angle between magnetisation and crystal
% axis, theta_strain, the angle between applied strain and crystal axis,
% and lambda, the magnetostriction coefficient.
% See Bozorth.
function Energy = StrainEnergy(MagAngle, strain, material)

% Direction cosines of M
alpha1 = cos(MagAngle);
alpha2 = cos(pi/2 - MagAngle);

stress = material.YoungModulus .* strain.magnitude;
Energy = -stress.*((3/2)* material.lambda_100.*((alpha1.^2) .* (strain.beta1.^2) + ...
    (alpha2.^2) .* (strain.beta2.^2)) + ...
    (3)*material.lambda_111.*(alpha1.*alpha2.*strain.beta1.*strain.beta2));
end