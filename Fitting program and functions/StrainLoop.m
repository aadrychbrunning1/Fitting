% This program produces hysteresis loops for a given material, applied
% field and strain.
% October 2010.
% Written by Duncan Parkes.  Based on 'fitloop' by James Haigh.
% All angles measured clockwise from [100] direction.

%% 1. Set up of field/material/strain parameters.
function [Hysteresis, Energies] = StrainLoop(Material, ConstantStrain, E_DW, FieldRange)
 global axis

% -------- Applied Field ------------
% Set up the range of fields applied and the angle to the [100] direction
% they will be applied.
% FieldStep = 0.5; % Oersteds (*0.1 for mT)
% FieldRange = -100:FieldStep:100; % Oersteds
FieldAngle=axis;
FieldParams = GetField(FieldRange, FieldAngle);
FieldParams.FieldStep = abs(FieldRange(1) - FieldRange(2));
% ------- Sample Parameters -------
% Material = 'FeGa';
SampleParams = GetMaterial(Material);

% %% 3. Generation of hysteresis loops:
% Find global minimum at each field strength
MagAngleRange = (540:-0.1:-180)*(pi/180);
% HkAll = ones(length(VariableStrainRange),2);

% ------- Applied Strain ----------
% Set the applied strain magnitude and angle between strain direction and
% [100] direction.
StrainAngle = 0; % Angle (degrees) between applied strain and 100 direction.

% ConstantStrain = -0.81*1e-4; % for generating energy vs angle graphs

% % Adjust the field angle to give hard axis loops.
% if ConstantStrain < 0
%     FieldParams.angle = 0;
% else
%     FieldParams.angle = pi/2;
% end
% axis=FieldParams.angle;


% Store strain parameters into a structure
StrainParams = GetStrain(ConstantStrain, StrainAngle);

% Positive strain -> field angle = 90
% Negative strain -> field angle = 0
% E_DW = 0.191*1e5;
SampleParams.E_DW = E_DW;
%     minAngleGlobal is currently the difference in local-global minAngle
Hysteresis = GetMinMag_incDW(SampleParams, FieldParams, StrainParams,MagAngleRange);
% figure;
PlotHysteresis(FieldParams, StrainParams,Hysteresis, SampleParams,'r');

% Calculate and save energies.
Energies = Energy(SampleParams, StrainParams, FieldParams.Hup,FieldParams.angle, MagAngleRange);

% Plot and or save energies
FieldSelection = 1;
% PlotEnergies(Energies, FieldSelection,FieldParams, StrainParams, MagAngleRange)
today = datestr(date, 'yyyy-mm-dd');
root_folder = 'StrainLoop';
ouput_folder=fullfile('Z:\output\',root_folder, today);
if (exist(ouput_folder, 'dir') == 0)
    mkdir (ouput_folder);
end

field_output_list = [0, -20, -38, -max(FieldRange)];
for i = 1:length(field_output_list)
    FieldSelection = field_output_list(i);
    FileName = sprintf('%s\\Energies_Field_%sOe.txt', ouput_folder, num2str(FieldSelection));
    SaveEnergies(Energies, FieldSelection,FieldParams, StrainParams, MagAngleRange, FileName)
end

end

