% Switching Fields
% For fitting switching fields to hysteresis loops.
% Version 0.2
clear all
close all
global ku
ku = -86e3

Strain = -0.29*1e-4;
E_DW = 0.273*1e5; %ergs/cm3
FieldStep = 0.5; %Oe
FieldRange = -100:FieldStep:100; %Oe
[Hysteresis, Energies] = StrainLoop('FeGa', Strain, E_DW, FieldRange);
Hk_up = Hysteresis.Hup_switch*1e-4;
Hk_dn = Hysteresis.Hdn_switch*1e-4;
% Hk = Hk(2:3)';
% Hk(1) = Hk(1) + FieldStep;
fprintf('Hk_up = %s mT\nHk_dn = %s mT\nStrain = %s\nE_DW = %s J/m^3\n', ... 
    num2str(Hk_up),num2str(Hk_dn), num2str(Strain), num2str(E_DW*0.1))

 