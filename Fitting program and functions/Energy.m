% Energy.m
% Material.OffsetAngle is used to make all angles measured from 100.
% Energy terms are:
% Zeeman, Uniaxial magnetocrystalline, Cubic magnetocrystalline and strain.
function Energy = Energy(Material, StrainStruct, Field, FieldAngle, MagAngle)
 global axis
UniaxialOffset = Material.UniaxialOffset;
CubicOffset = Material.CubicOffset;


% Retrieve the matrix versions of the Field and Magnetisation-angle arrays.
% Should be possible to speed up code by making this line external from the
% energy function.
[FieldMatrix, MagAngle] = EnergyArray(Field, MagAngle);

Energy.Zeeman = ZeemanEnergy(FieldMatrix, (FieldAngle)-MagAngle, Material);

Energy.Strain = StrainEnergy(MagAngle, StrainStruct, Material);

Energy.Uniaxial = UniAnisEnergy(Material.Ku, MagAngle, UniaxialOffset);

Energy.Cubic = CubicAnisEnergy(Material.Kc, MagAngle,CubicOffset);

Energy.Total = Energy.Zeeman + Energy.Strain + Energy.Uniaxial + Energy.Cubic;
% Energy.Total = Energy.Zeeman + Energy.Strain  + Energy.Cubic;
end