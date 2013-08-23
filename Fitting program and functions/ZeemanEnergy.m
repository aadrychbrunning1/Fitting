% Function to calculate the Zeeman energy due to a magnetic moment in a
% magnetic field, H.
% Energy = ZeemanEnergy(H, Ms, angle)
function Energy = ZeemanEnergy(H, angle, Material)
Ms = Material.Ms;
Energy = (-(H*Ms).*cos(angle));

end