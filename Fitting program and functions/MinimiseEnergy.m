% [indices minE]= MinimiseEnergy(Material, Strain, Field, FieldAngle, MagAngle)
% This function finds the minimum energy values.
% These values are used to find the corresponding angles which produced
% those energies.
% MagAngle is a particular magnetisation angle.
% Material: structure containing material paramters
% Strain: structure containing strain parameters
% Field: Hup(i) or Hdn(i)
% Theta: current angle
function [minTheta, minE] = MinimiseEnergy(Material, Strain, Field, FieldAngle, theta)

dTheta = pi/5000;
% fprintf('Field = %d\n', Field')

% find the energy at this value of theta (magnetisation angle)
E0 = Energy(Material, Strain, Field, FieldAngle, theta);
E0 = E0.Total;
% fprintf('E0_init = %d\n', E0);

% Find the energy at a small angle greater than theta
Eplus = Energy(Material, Strain, Field, FieldAngle, theta+dTheta);
Eplus = Eplus.Total;
% fprintf('Eplus_init = %d\n', E0);

% Find the energy at a small angle greater than theta
Eminus = Energy(Material, Strain, Field, FieldAngle, theta-dTheta);
Eminus = Eminus.Total;
% fprintf('Eminus_init = %d\n', E0);

if((E0 < Eminus) && (Eplus > E0))
    %     \_/ -> increasing theta
    % minus0plus		Then we are in a minimum and theta is correct
    theta = theta;
%     fprintf('The value of theta = %d was correct\n',  theta);

elseif((Eminus > E0) &&( E0 > Eplus))
    %     \_    -> increasing theta
    %       \
    %      	increase theta, taking us down the hill, until Eplus > E0
    while (E0 > Eplus)
        
        theta = theta + dTheta;
        E0 = Energy(Material, Strain, Field, FieldAngle, theta);
        E0 = E0.Total;
        Eplus= Energy(Material, Strain, Field, FieldAngle, theta+dTheta);
        Eplus = Eplus.Total;
%         fprintf('((Eminus > E0) &&( E0 > Eplus)),\n Eplus = %d, E0 = %d', Eplus, E0);
    end
    
elseif((Eminus < E0) && (E0 < Eplus))
    %      _/   -> increasing theta
    %     /
    % 		decrease theta, taking us down the hill, until Eminus > E0
    while (Eminus < E0)
        
        theta = theta - dTheta;
        E0 = Energy(Material, Strain, Field, FieldAngle, theta);
        E0 = E0.Total;
        Eminus = Energy(Material, Strain, Field, FieldAngle, theta-dTheta);
        Eminus = Eminus.Total;
%         fprintf('((Eminus < E0) && (E0 < Eplus)),\n Eminus = %d, E0 = %d', Eminus, E0);
    end
    
elseif((Eminus < E0) && (Eplus < E0))
    %     _     -> increasing theta
    %    / \
    %      		help, dont know what to do as is peak.
    %      		=> go in random direction:
    if (rand() > 0.5)
        %         random decision to Increase theta
        while (E0 > Eplus)
%               while _
%                      \
%               Take us off the peak then calculate the new energies.

            theta = theta + dTheta;
            E0 = Energy(Material, Strain, Field, FieldAngle, theta);
            E0 = E0.Total;
            Eplus = Energy(Material, Strain, Field, FieldAngle, theta+dTheta);
            Eplus = Eplus.Total;
%             fprintf('((Eminus < E0) && (Eplus < E0)),\n Eplus = %d, E0 = %d', Eplus, E0);
        end
        
    else
        %     random decision to Decrease theta
        while (Eminus < E0)
%             while _
%                  /
            theta = theta - dTheta;
            E0 = Energy(Material, Strain, Field, FieldAngle, theta);
            E0 = E0.Total;
            Eminus = Energy(Material, Strain, Field, FieldAngle, theta-dTheta);
            Eminus = Eminus.Total;
%             disp(sprintf('((Eminus < E0) && (Eplus < E0)),\n Eminus = %d, E0 = %d', Eminus, E0));
        end
    end
end

% 	Put theta back between pi -pi, since there could have been
% 	significant change in theta.
if( theta > pi)
    
    theta = theta - 2*pi;
    
elseif (theta < -pi )
    
    theta = theta + 2*pi;
end

% 	we know that theta is between theta + s:theta -s so adjust the value of
% 	dTheta until the difference is less than 1e-8 and thus home in on the
% 	actual value of theta.

while (dTheta>1e-8)
    
    dTheta = dTheta/2.0;
    
    %     Calculate over- and under-estimated energies.
    Eplus = Energy(Material, Strain, Field, FieldAngle, theta+dTheta);
    Eplus = Eplus.Total;
    E0 = Energy(Material, Strain, Field, FieldAngle, theta);
    E0 = E0.Total;
    Eminus = Energy(Material, Strain, Field, FieldAngle, theta-dTheta);
    Eminus = Eminus.Total;
    
    %     Check that E0 is still less than Eminus
    if E0 < Eminus
        %         If it is then we are at the minimumising angle.
        theta = theta;
    else
        %         Otherwise
        theta = theta-dTheta;
    end
    
    if E0 < Eplus
        theta = theta;
    else
        theta = theta + dTheta;
    end
end
minTheta = theta;
minE = [E0, Eminus, Eplus];
end

