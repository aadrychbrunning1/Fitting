% This function gets the different parameters for the sample material.
function material = GetMaterial(Name)
global ku
global kc
switch Name
    case 'FeGa'
        material.name = 'FeGa';
        material.YoungModulus = 140e10; % (Ba)
        material.Ms = 1378;             %(emu/cm3)
        material.Volume = 1e-7; % cm3
        
        material.lambda_111 = -16e-6;
        material.lambda_100 = 200e-6;
        
        material.Kc = kc;           % (erg/cm3)
        
        material.Ku = ku;%-86e3;
        ku
%         material.Kc = 327e3;%510e3;            % (erg/cm3)
%         material.Ku = -86e3;%-118.0e3;            % (erg/cm3)
        
        % Angle that uniaxial easy axis is offset from [100].  ensures that
        % the [100] direction is at zero degrees.
        material.UniaxialOffset = 45*(pi/180);
        
        % Angle between [100] and cubic easy axis.  E.g. [110] is
        % 45degrees.
        %         ensures that [100] direction is zero degrees.
        material.CubicOffset = 45*(pi/180);
        
%         Set default energy energy cost of forming a domain wall.
        material.E_DW = 500e5;
%         Copy and modify the following parameters to store a new material
%         in this function.
    case 'NEW MATERIAL'
        material.name = 'Material Name';
        material.YoungModulus = 140e10; % (Ba)
        material.Ms = 1600;             %(emu/cm3)
        material.Volume = 1e-7; % cm3
        
        material.lambda_111 = -16e-6;
        material.lambda_100 = 200e-6;
        
        
        material.Kc = 510e3;            % (erg/cm3)
        material.Ku = -118.0e3;            % (erg/cm3)



        % Angle that uniaxial easy axis is offset from [100].  ensures that
        % the [100] direction is at zero degrees.
        material.UniaxialOffset = 45*(pi/180);
        
        % Angle between [100] and cubic easy axis.  E.g. [110] is
        % 45degrees.
        %         ensures that [100] direction is zero degrees.
        material.CubicOffset = 45*(pi/180);
    otherwise
        material.name = 'FeGa';
        material.YoungModulus = 140e10; % (Ba)
        material.Ms = 1600;             %(erg/cm3)
        
        material.lambda_111 = -16e-6;
        material.lambda_100 = 200e-6;
        
        material.Kc = 400e3;            % (erg/cm3)
        material.Ku = -100e3;            % (erg/cm3)
        
        % Angle that uniaxial easy axis is offset from [100]
        material.UniaxialOffset =45*(pi/180);
        
        material.CubicOffset =45*(pi/180);
end

end