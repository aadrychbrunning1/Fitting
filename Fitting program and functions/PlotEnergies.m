%  PlotEnergies(Energies, FieldSelection,FieldParams, StrainParams)
% Plot the total and consituent energy terms for a selected applied field
% magnitude.

function PlotEnergies(Energies, FieldSelection,FieldParams, StrainParams, MagAngleRange)

FieldIndex = FieldPlotSelect(FieldParams.Hup,FieldSelection);
[Y,I] = min(Energies.Total(:,FieldIndex));
figure
hold on
plot((180/pi)*MagAngleRange,Energies.Uniaxial(:,FieldIndex),'b-.', 'LineWidth',2)
plot((180/pi)*MagAngleRange,Energies.Cubic(:,FieldIndex),'r--.', 'LineWidth',2)
plot((180/pi)*MagAngleRange,Energies.Zeeman(:,FieldIndex),'c--.', 'LineWidth',2)
plot((180/pi)*MagAngleRange,Energies.Total(:,FieldIndex),'k','LineWidth',2)
plot((180/pi)*MagAngleRange,Energies.Strain(:,FieldIndex),'g--.', 'LineWidth',2)
plot((180/pi)*MagAngleRange(I),Y,'x', 'LineWidth',2)
legend('Uniaxial', 'Cubic','Zeeman','Total','Strain','location', 'best');
xlabel('Angle(degrees) from [100]')
ylabel('Total Energy Density');
title(sprintf('Energy density as function of magnetisation angle.  \n Field = %d Oe offset %g degrees, strain = %g offset %d degrees', ...
    FieldSelection, (180/pi)*FieldParams.angle, StrainParams.magnitude,(180/pi)*StrainParams.angle));
hold off
end