% Ku & Kc change 
% For fitting simulation to raw data

clear all
close all
global y_output % Takes the simulation output and re enters new simulation 
% data as Kc and Ku is varied. 

global Sat_mag % Takes the saturaton magnetisation from the simulation and 
% reenters it in to loop as conditions are varied. 

global ku; % Inputs varied values of Ku in to GetMaterial function.

global kc; % Inputs varied values of Kc in to GetMaterial function.

global axis; % Inputs varied values of the field angle in to GetField function.

axis=45; % Angle from [100] direction in degrees. 
%Mup = load('Mup_S316_06_[1-10].dat');
%Mdn=load ('Mdn_S316_06_[1-10].txt');

Mup=load('Mup_test.dat'); % Need to load raw data for sweep up hysteresis 
% loop and divide this data by the saturation moment.
% First column should be field and second column the normalised data. 

Mdn=load('Mup_test.dat');

% If can, set raw data to your pre set field range, otherwise the memory on
% MATLAB will run out before it can plot anything. 

% Can set whether to view simulation figures or not by commenting out the
% word 'figure' above PlotHysteresis function in StrainLoop.

Strain = 0;
E_DW = 0.01; %ergs/cm3
FieldStep = 5; %Oe
FieldRange = -100:FieldStep:100; %Oe
n=1;
tic

for ku = 40e3:1000:70e3; % Set the choosen range of Ku values
    i=1;
    x(n)=ku; % Saves all values of Ku in array x
    for kc = -100:100:100; % Set the choosen range of Kc values
        x1(i)=kc; % Saves all values of Kc in array x1
        
        [Hysteresis, Energies] = StrainLoop('FeGa', Strain, E_DW, FieldRange);
        % Runs the Starin loop function which calculates the simulated
        % data.
        Hk_up = Hysteresis.Hup_switch*1e-4; % Determines the field value 
        % where switching event occurs.
        Hk_dn = Hysteresis.Hdn_switch*1e-4;


        diff_up(i,n)=sum((((y_output(1,:)'/Sat_mag))-(Mup(:,2))).^2); 
        % Finds the sum of the squares of the difference between the
        % simulated data and the input raw data of sweep up hysteresis loop. 
        
        diff_dn(i,n)=sum((((y_output(2,:)'/Sat_mag))-(Mdn(:,2))).^2);


        i=i+1;
    end
n=n+1;
end
toc
figure(2)
surf(x,x1,diff_up) % Plots a 3D graph of the Ku (x axis), Kc (y axis), and 
% the sum of squares (z axis) for sweep up of hysteresis loop.
xlabel('Ku, (ergs/cm^3)')
ylabel('Kc, (ergs/cm^3)')
zlabel('Diff sweep up')
figure(3)
surf(x,x1,diff_dn)
xlabel('Ku, (ergs/cm^3)')
ylabel('Kc, (ergs/cm^3)')
zlabel('Diff sweep down')

MIN_up=min(min(diff_up)); % Finds the minimum in the difference array for 
% sweep up.
o=find(diff_up==MIN_up); % Finds the position of the said minimum in the 
% difference array.
[r, c] = size(diff_up); % Calculates the number of rows (number of kc) and 
% columns (number of ku) in the difference array.

c = ceil(o/r); % Finds the column number for position of minimum in
% difference array.
ku_up_output=x(c); % Uses the column number to find the corresponding Ku 
% value.
kc_up_output=x1(o - (c-1)*r); % Uses the position of minimum with column 
% and row number of difference array to find the corresponding kc value for
% the sweep up of hysteresis loop. 
disp(['Ku up = ',num2str(ku_up_output),' ergs/cm^3']);
disp(['Kc up = ',num2str(kc_up_output),' ergs/cm^3']);
MIN_dn=min(min(diff_dn));

o1=find(diff_dn==MIN_dn);
[r1, c1] = size(diff_dn);
ku_dn_output=x(ceil(o1/r));
kc_dn_output=x1(floor(o1/c1));
disp(['Ku up = ',num2str(ku_dn_output),' ergs/cm^3']);
disp(['Kc up = ',num2str(kc_dn_output),' ergs/cm^3']);

ku_avg=(sum(ku_up_output+ku_dn_output))/2; % Takes an average of the output
% Ku for the sweep up and sweep down of hysteresis loop to output one
% value.
kc_avg=(sum(kc_up_output+kc_dn_output))/2;

disp(['Final Ku= ',num2str(ku_avg),' ergs/cm^3']);
disp(['Final Kc= ',num2str(kc_avg),' ergs/cm^3']);

