%  PlotEnergies(Energies, FieldSelection,FieldParams, StrainParams)
% Plot the total and consituent energy terms for a selected applied field
% magnitude.

function SaveEnergies(Energies, FieldSelection,FieldParams, StrainParams, MagAngleRange, FileName)

% disp('Saving Energies...')
FieldIndex = FieldPlotSelect(FieldParams.Hup,FieldSelection);
EnergyConversion = 1e-1;
MagAngleRange = (180/pi)*MagAngleRange';
Uniaxial = EnergyConversion*Energies.Uniaxial(:,FieldIndex);
Cubic = EnergyConversion*Energies.Cubic(:,FieldIndex);
Zeeman = EnergyConversion*Energies.Zeeman(:,FieldIndex);
Total = EnergyConversion*Energies.Total(:,FieldIndex);
Strain = EnergyConversion*Energies.Strain(:,FieldIndex);

fileID = fopen(FileName, 'w');
fprintf(fileID,'%13s\t%13s\t%13s\t%13s\t%13s\t%13s\n','MagAngleRange','Uniaxial', 'Cubic', 'Zeeman', 'Total', 'Strain');
fprintf(fileID,'%13s\t%13s\t%13s\t%13s\t%13s\t%13s\n','Degrees','J/m3', 'J/m3', 'J/m3', 'J/m3', 'J/m3');
fclose(fileID);
% fprintf(fileID,'%6.2f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\n',[MagAngleRange, Uniaxial, Cubic, Zeeman, Total, Strain]);
dlmwrite(FileName, [MagAngleRange, Uniaxial, Cubic, Zeeman, Total, Strain], '-append', 'delimiter','\t', 'precision', 6);


% save(FileName,'MagAngleRange','Uniaxial','Cubic','Total','Strain', 'Zeeman', '-ascii', '-tabs')


%title(sprintf('Energy density as function of magnetisation angle.  \n Field = %d Oe offset %g degrees, strain = %g offset %d degrees', ...
   % FieldSelection, (180/pi)*FieldParams.angle, StrainParams.magnitude,(180/pi)*StrainParams.angle));
%hold off
end