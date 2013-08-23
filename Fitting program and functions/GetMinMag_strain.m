% minMag = GetMinMag(SampleParams, FieldParams, StrainParams)
%  Minimisation of energy to find the magnetisation directions.
%  In this cell I loop through each of the values of field, finding
%  the minimimum energy in each case.
function [minMagcos minMagsin minAngle minEnergy] = GetMinMag(SampleParams, FieldParams, StrainParams)


% set initial magnetisation angle along applied field direction.  If we
% begin with initially large applied field we can assume this.
[theta_up theta_dn] = GetAngle(FieldParams.angle);

minMagcosup = zeros(1,length(FieldParams.Hup));
minMagcosdn = zeros(1,length(FieldParams.Hdn));
minMagsinup = zeros(1,length(FieldParams.Hup));
minMagsindn = zeros(1,length(FieldParams.Hdn));

minEup = zeros(length(FieldParams.Hup),3);
minEdn = zeros(length(FieldParams.Hup),3);

upAngle = zeros(1,length(FieldParams.Hup));
dnAngle = zeros(1,length(FieldParams.Hdn));


for i = 1:length(FieldParams.Hup)
%     Feed in the magnetisation angle (the accounting for the offsets and
%     zeeman term occurs within the energy function.

% Calculate for the up stroke
   [theta_up minEup(i,:)] = MinimiseEnergy(SampleParams, StrainParams.Sup(i), FieldParams.Hup(i), FieldParams.angle, theta_up);
   minMagcosup(i) = (SampleParams.Ms)*cos((FieldParams.angle)-theta_up);
   minMagsinup(i) = (SampleParams.Ms)*-sin((FieldParams.angle)-theta_up);
   upAngle(i) = ((FieldParams.angle)-theta_up);
   %    Calculate for the down stroke
   [theta_dn minEdn(i,:)] = MinimiseEnergy(SampleParams, StrainParams.Sdn(i), FieldParams.Hdn(i), FieldParams.angle, theta_dn);

   minMagcosdn(i) = (SampleParams.Ms)*cos((FieldParams.angle)-theta_dn);
   minMagsindn(i) = (SampleParams.Ms)*-sin((FieldParams.angle)-theta_dn);
   dnAngle(i) = ((FieldParams.angle)-theta_dn);
end

minMagcos = [minMagcosup; minMagcosdn];
minMagsin = [minMagsinup; minMagsindn];
% minAngle = [upAngle; dnAngle]; % between M and B
minAngle = [FieldParams.angle - upAngle; FieldParams.angle - dnAngle]; % between M and [100]
minEnergy = [minEup(:,1) minEdn(:,1)];
end