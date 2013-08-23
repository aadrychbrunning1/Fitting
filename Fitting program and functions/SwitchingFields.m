% Switching Fields
% For fitting switching fields to hysteresis loops.
% Version 0.2
clear all
close all
global y_output
global Sat_mag
global ku
global kc
ku = 25e3;
oo1 = ku;
plus = -1;
kc=0;

% Mup = load('Mup_S316_06_[1-10].dat');
% Mdn=load ('Mdn_S316_06_[1-10].txt');

Strain = 0;
E_DW = 0.0*1e5; %ergs/cm3
FieldStep = 1; %Oe
FieldRange = -100:FieldStep:100; %Oe
[Hysteresis, Energies] = StrainLoop('FeGa', Strain, E_DW, FieldRange);
Hk_up = Hysteresis.Hup_switch*1e-4;
Hk_dn = Hysteresis.Hdn_switch*1e-4;
% Hk = Hk(2:3)';
% Hk(1) = Hk(1) + FieldStep;
fprintf('Hk_up = %s mT\nHk_dn = %s mT\nStrain = %s\nE_DW = %s J/m^3\n', ...
    num2str(Hk_up),num2str(Hk_dn), num2str(Strain), num2str(E_DW*0.1))

% diff_up=sum((((y_output(1,:)'/Sat_mag)).^2)-(Mup(:,2)));
% 
% ku = -300e3;
% oo2 = ku;
% up = 1;
% dd = 100;
% while dd > 0.0005
%     
%     Strain = 0;
%     E_DW = 0.273*1e5; %ergs/cm3
%     FieldStep = 5; %Oe
%     FieldRange = -100:FieldStep:100; %Oe
%     [Hysteresis, Energies] = StrainLoop('FeGa', Strain, E_DW, FieldRange);
%     Hk_up = Hysteresis.Hup_switch*1e-4;
%     Hk_dn = Hysteresis.Hdn_switch*1e-4;
%     % Hk = Hk(2:3)';
%     % Hk(1) = Hk(1) + FieldStep;
%     fprintf('Hk_up = %s mT\nHk_dn = %s mT\nStrain = %s\nE_DW = %s J/m^3\n', ...
%         num2str(Hk_up),num2str(Hk_dn), num2str(Strain), num2str(E_DW*0.1))
%     
%     
%     % figure(2)
%     % Filename=input('Please input file name ','s');
%     % FLE = load(Filename);
%     % X1 = FLE(:,2);
%     % Y1 = FLE(:,4);
%     % X=X1.*1e-4; % Converts Oe in to Tesla
%     % Hs=X(1,1);
%     % Ms1=(sum(Y1(1:5,1)))./5;
%     % vol=1.481e-7;
%     % Ms=Ms1/vol;
%     % Y=Y1./Ms1;
%     % plot(X,Y)
%     % axis([-0.01 0.01 -1 1])
%     
% %     figure (2)
% %     File1=input('Please input Mup file ', 's');
% %     File2=input('Please input Mdn file ', 's');
% %     Mup=load(File1);
% %     Mdn=load(File2);
% %     plot(Mup(:,1)*1e-4,Mup(:,2),'r');
% %     hold all
% %     plot(Mdn(:,1)*1e-4,Mdn(:,2),'b');
%     
%     dd=sum(((Mup(:,2))-(y_output(1,:)'/Sat_mag)).^2) % Finds the difference along
%     %the y axis between the raw data and the simulated data.
%         
%     if up == 1
%         diff_up_2 = dd; 
% %     elseif up == 0
% %         diff_up = dd;
%     end
%          
%     if diff_up > diff_up_2
%         up = 0;
%         oo1 = (oo1 + oo2)/2;
%         ku = oo1;
%     elseif diff_up <= diff_up_2
%         up = 1;
%         oo2 = (oo1 + oo2)/2;
%         ku = oo2;
%     end
% 
% end
