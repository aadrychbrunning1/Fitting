% PlotHysteresis(FieldParams, StrainParams,minMag, Ms,Linespec)
function PlotHysteresis(FieldParams, StrainParams,Hysteresis, SampleParams,Linespec)
global y_output
global Sat_mag 
global axis
minMag = Hysteresis.minMagcos;
y_output = minMag;
Ms = SampleParams.Ms;
Sat_mag=Ms;
% scrsz = get(0,'ScreenSize');
% figure('Position',[0 0 scrsz(3) scrsz(4)])
% 
% % Plot of magnetisation vs applied field
% subplot(2,2,1)
hold on
plot(FieldParams.Hup*(1e-4),minMag(1,:)/Ms,'r', 'linewidth', 2);
plot(FieldParams.Hdn*(1e-4),minMag(2,:)/Ms,'b', 'linewidth', 2);
xlabel('Applied field (T)')
ylabel('M/M_{s}')
title('Magnetisation projection')
legend('Hup', 'Hdn','location', 'best')
hold off

% 
% % Plot of magnetisation angle vs applied field
% subplot(2,2,2)
% hold on
% %plot(FieldParams.Hup*(1e-4),acos(cos(Hysteresis.minAngleGlobal(1,:)))*(180/pi),'r-', 'linewidth', 2);
% %plot(FieldParams.Hdn*(1e-4),acos(cos(Hysteresis.minAngleGlobal(2,:)))*(180/pi),'b-', 'linewidth', 2);
% %plot(FieldParams.Hup*(1e-4),acos(cos(Hysteresis.minAngle(1,:)))*(180/pi),'r--', 'linewidth', 2);
% %plot(FieldParams.Hdn*(1e-4),acos(cos(Hysteresis.minAngle(2,:)))*(180/pi),'b--', 'linewidth', 2);
% %title(sprintf('Mag. angle for Applied field angle %d',FieldParams.angle*(180/pi)));
% hold off
% xlabel('Applied field (T)')
% ylabel('Magnetisation Angle (Degrees)')
% legend('Global up', 'GLobal dn', 'Local up', 'Local dn','location', 'best')
% % legend('Hup', 'Hdn','location', 'best')
% 
% subplot(2,2,3)
% hold on 
% plot(FieldParams.Hup*(1e-4), Hysteresis.DeltaE(1,:)*1e-1,'r-', 'linewidth', 2)
% plot(FieldParams.Hdn*(1e-4), Hysteresis.DeltaE(2,:)*1e-1,'b-', 'linewidth', 2)
% hold off
% xlabel('Field (T)')
% ylabel('Delta E (J/m^3)');
% title('Energy Density difference between local and global minimum');
% % legend('Hup', 'Hdn','location', 'best')
% 
%  subplot(2,2,4);
% %  text(0.2,0.8,sprintf('E_{DW} = %s J/m^{3}', num2str(SampleParams.E_DW*1e-1)));
% %  text(0.2,0.6,sprintf('K_{strain} = %s', num2str(StrainParams.magnitude))); 
% %  text(0.2,0.4,sprintf('Field Step = %g mT', FieldParams.FieldStep*(1e-1))); 
% %  axis off;
% hold on 
% plot(FieldParams.Hup*(1e-4), Hysteresis.minEnergyGlobal(1,:)*1e-1,'r-', 'linewidth', 2)
% plot(FieldParams.Hdn*(1e-4), Hysteresis.minEnergyGlobal(2,:)*1e-1,'b-', 'linewidth', 2)
% plot(FieldParams.Hup*(1e-4), Hysteresis.minEnergy(1,:)*1e-1,'r--', 'linewidth', 2)
% plot(FieldParams.Hdn*(1e-4), Hysteresis.minEnergy(2,:)*1e-1,'b--', 'linewidth', 2)
% legend('Global up', 'GLobal dn', 'Local up', 'Local dn','location', 'best')
% hold off
% xlabel('Field (T)')
% ylabel('E (J/m^3)');
% title('Local and Global Energy Minima');
% 
% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0
% 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% 
% text(0.5, 1,sprintf('E_{DW} = %s J/m^{3}, K_{strain} = %s, Field Step = %g mT', ... 
%     num2str(SampleParams.E_DW*1e-1), num2str(StrainParams.magnitude), ... 
%     FieldParams.FieldStep*(1e-1)),'HorizontalAlignment', ...
%     'center','VerticalAlignment', 'top')
% set(gcf,'Position',[0 0 scrsz(3) scrsz(4)])
end