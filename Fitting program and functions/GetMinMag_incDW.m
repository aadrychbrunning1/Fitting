% minMag = GetMinMag(SampleParams, FieldParams, StrainParams)
%  Minimisation of energy to find the magnetisation directions.
%  In this cell I loop through each of the values of field, finding
%  the minimimum energy in each case.
function Hysteresis = GetMinMag_incDW(SampleParams, FieldParams, StrainParams,MagAngleRange)
global kc
global axis 

% Set the max cost of a domain wall;
E_DW = SampleParams.E_DW;
EnergiesUp = Energy(SampleParams, StrainParams, FieldParams.Hup,FieldParams.angle, MagAngleRange);
EnergiesDn = Energy(SampleParams, StrainParams, FieldParams.Hdn,FieldParams.angle, MagAngleRange);
% set initial magnetisation angle along applied field direction.  If we
% begin with initially large applied field we can assume this.
[theta_up, theta_dn] = GetAngle(FieldParams.angle);



minMagcosup = zeros(1,length(FieldParams.Hup));
minMagcosdn = zeros(1,length(FieldParams.Hdn));
minMagsinup = zeros(1,length(FieldParams.Hup));
minMagsindn = zeros(1,length(FieldParams.Hdn));
minEupglob = zeros(1,length(FieldParams.Hdn));
minEdnglob = zeros(1,length(FieldParams.Hdn));
indexEupglob = zeros(1,length(FieldParams.Hdn));
indexEdnglob = zeros(1,length(FieldParams.Hdn));
minAngleupglob = zeros(1,length(FieldParams.Hdn));
minAnglednglob = zeros(1,length(FieldParams.Hdn));
deltaEup = zeros(1,length(FieldParams.Hdn));
deltaEdn = zeros(1,length(FieldParams.Hdn));
DiffAngle_up = zeros(1,length(FieldParams.Hdn));
DiffAngle_dn = zeros(1,length(FieldParams.Hdn));

minEup = zeros(length(FieldParams.Hup),3);
minEdn = zeros(length(FieldParams.Hup),3);

upAngle = zeros(1,length(FieldParams.Hup));
dnAngle = zeros(1,length(FieldParams.Hdn));

Hdn_switch = 0;
Hup_switch = 0;



Hup_i = 1;
Hdn_i = 1;

% count = 1;
% Find magnetisation direction for each value of applied field
for i = 1:length(FieldParams.Hup)
    %     FieldIndexUp = FieldPlotSelect(FieldParams.Hup,FieldParams.Hup(i));
    %     FieldIndexDn = FieldPlotSelect(FieldParams.Hdn,FieldParams.Hdn(i));
    
    %     Find GLOBAL MINIMUM ENERGY for each applied field strength
    [minEupglob(i), indexEupglob ] = min(EnergiesUp.Total(:,i));
    [minEdnglob(i), indexEdnglob ] = min(EnergiesDn.Total(:,i));
    %     angle at which global minimum occurs.
    
    minAngleupglob(i) = MagAngleRange(indexEupglob);
    minAnglednglob(i) = MagAngleRange(indexEdnglob);
    
    %     if minAngleupglob(i) > pi/4
    %         minAngleupglob(i) = minAngleupglob(i) + pi/2;
    %     end
    %
    %     if minAnglednglob(i) > pi/4
    %         minAnglednglob(i) = minAnglednglob(i) + pi/2;
    %     end
    
    %     Feed in the magnetisation angle (the accounting for the offsets and
    %     zeeman term occurs within the energy function.
    
    %     CALCULATE LOCAL ENERGIES
    % Calculate for the up stroke
    [theta_up, minEup(i,:)] = MinimiseEnergy(SampleParams, StrainParams, FieldParams.Hup(i), FieldParams.angle, theta_up);
    %    Calculate for the down stroke
    [theta_dn, minEdn(i,:)] = MinimiseEnergy(SampleParams, StrainParams, FieldParams.Hdn(i), FieldParams.angle, theta_dn);
    
    %         CHECK ENERGY DIFFERENCE AGAINST DOMAIN WALL FORMATION
    %     %    Calculate difference in energy between local minima and global minima
    deltaEup(i) = minEup(i,1) - minEupglob(i);
    deltaEdn(i) = minEdn(i,1) - minEdnglob(i);
    %
    % %     Difference in angles between current angle and global minimum angle
    DiffAngle_up(i) = theta_up - minAngleupglob(i);
    DiffAngle_dn(i) = theta_dn - minAnglednglob(i);
    
    
    % Move to the global minimum if deltaE lowers the energy by more than the
    % cost of a domain wall.
    %     sin(0.5*DiffAngle_up)
    % Trying to make it less likely/more costly to rotate the magnetisation
    % significantly away from the current magnetisation direction.  No such
    % luck at the moment.
    AngDependenceUp = 1;%sin(0.5*DiffAngle_up);
    AngDependenceDn = 1;%sin(0.5*DiffAngle_dn);
    
    if abs(deltaEup(i)) > abs(E_DW*AngDependenceUp)
        theta_up = minAngleupglob(i);
        Hup_switch(Hup_i) = FieldParams.Hup(i);
        Hup_i = Hup_i + 1;
        
        %     fprintf('If is true for field Hup = %g\n', FieldParams.Hup(i))
        % disp(abs(deltaEup(i)));
        % disp(abs(DiffAngle_up(i)));
    end
    if abs(deltaEdn(i)) > abs(E_DW*AngDependenceDn)
        theta_dn = minAnglednglob(i);
        Hdn_switch(Hdn_i) = FieldParams.Hdn(i);
       
        Hdn_i = Hdn_i + 1;
        %         fprintf('If is true for field Hdn = %g\n', FieldParams.Hdn(i))
    end
    %     upAngle(i) = ((FieldParams.angle)-theta_up);
    %     dnAngle(i) = ((FieldParams.angle)-theta_dn);
    upAngle(i) = theta_up;
    dnAngle(i) = theta_dn;
    %     MAGNETISATION
    % Calculate magnetisation based on either the local minimum, or the global
    % minimum, if a domain wall was allowed to be formed.
    
    %   Determine magnetisation components from the angles
    minMagcosup(i) = (SampleParams.Ms)*cos(acos(cos((FieldParams.angle)-theta_up)));
    minMagsinup(i) = (SampleParams.Ms)*-sin((FieldParams.angle)-theta_up); % not sure about minus sign (-sin)
    %    upAngle(i) = ((FieldParams.angle)-theta_up);
    
    
    
    %    Determine magnetisation components from the angles
    minMagcosdn(i) = (SampleParams.Ms)*cos(acos(cos((FieldParams.angle)-theta_dn)));
    minMagsindn(i) = (SampleParams.Ms)*-sin((FieldParams.angle)-theta_dn); % not sure about minus sign (-sin)
    %        dnAngle(i) = ((FieldParams.angle)-theta_dn);
    
    % count = count + 1;
    %     disp(count)
    
end

Hysteresis.DeltaE = [deltaEup; deltaEdn];
Hysteresis.minMagcos = [minMagcosup; minMagcosdn];
Hysteresis.minMagsin = [minMagsinup; minMagsindn];
Hysteresis.minAngle = [upAngle; dnAngle]; % between M and B
Hysteresis.minAngle = [FieldParams.angle - upAngle; FieldParams.angle - dnAngle]; % between M and [100]
Hysteresis.minAngleGlobal = [FieldParams.angle - minAngleupglob; FieldParams.angle - minAnglednglob];% between M and [100]
Hysteresis.DiffAngle = [DiffAngle_up; DiffAngle_dn];
Hysteresis.minEnergy = [minEup(:,1)'; minEdn(:,1)'];
Hysteresis.minEnergyGlobal = [minEupglob; minEdnglob];
Hysteresis.Hup_switch = Hup_switch;
Hysteresis.Hdn_switch = Hdn_switch;
end