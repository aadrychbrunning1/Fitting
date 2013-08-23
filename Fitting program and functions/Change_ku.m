% Switching Fields
% For fitting switching fields to hysteresis loops.
% Version 0.2
clear all
close all
global y_output
global Sat_mag
global ku
Mup = load('Mup_S316_06_[1-10].dat');
Mdn=load ('Mdn_S316_06_[1-10].txt');
Strain = 0;
E_DW = 0.273*1e5; %ergs/cm3
FieldStep = 5; %Oe
FieldRange = -100:FieldStep:100; %Oe
n=1
for ku = -0.5e3:100:0.5e3;
    x(n)=ku
[Hysteresis, Energies] = StrainLoop('FeGa', Strain, E_DW, FieldRange);
% Hk_up = Hysteresis.Hup_switch*1e-4;
% Hk_dn = Hysteresis.Hdn_switch*1e-4;
% % Hk = Hk(2:3)';
% % Hk(1) = Hk(1) + FieldStep;
% fprintf('Hk_up = %s mT\nHk_dn = %s mT\nStrain = %s\nE_DW = %s J/m^3\n', ...
%     num2str(Hk_up),num2str(Hk_dn), num2str(Strain), num2str(E_DW*0.1))

diff_up(n)=sum((((y_output(1,:)'/Sat_mag))-(Mup(:,2))).^2);
diff_dn(n)=sum((((y_output(2,:)'/Sat_mag))-(Mdn(:,2))).^2);
n=n+1
end
figure(2)
hold all
plot(x, diff_up)

plot(x, diff_dn)
