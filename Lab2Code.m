%%%Lab #2 Code
%%%Lab Section: 3 
%%%Lab group #1
%%%Written by: Jake Falck

%%%Outputs%%%
    %%Calculated Values: 
        %K - wind tunnel constant linearly relating two static
        %b - slope of line relating f_mot to test section velocity
        %Equation relating f_mot to test section velocity (figure 2)
    %%Plots: 
        %change in pressure  vs. dynamic pressure (figure 1)
        %test section velocity (m/s) vs. motor speed (Hz) (figure 2)
     
close all;clear;clc;format long
%%%Constants
g = 9.81; %gravity (m/s^2)
theta_m = 90-17.7; % Tilt angle of manometer rack
P_ref = 1000*100;%ambient pressure(hPa) -> Pa 
R=287.05; % Gas Constant for air (J/(kg*K))
rho_f = 997; %Density of water (kg/m^3)
in2m = .0254; %conversion factor from inch to meter

%%%Importing Experiment Data from Excel Sheet
f_mot = xlsread('Experimental Data.xlsx','Sheet1','B2:B10');% Motor Frequency (Hz)
Href = xlsread('Experimental Data.xlsx','Sheet1','C2:C10')*in2m;% Manometer height of ref pressure (m)
Ha = xlsread('Experimental Data.xlsx','Sheet1','D2:D10')*in2m;% Manometer height of point a pressure (m)
He = xlsread('Experimental Data.xlsx','Sheet1','E2:E10')*in2m;% Manometer height of point e pressure (m)
H_tot = xlsread('Experimental Data.xlsx','Sheet1','F2:F10')*in2m;%Manometer height of total pressure inside tunnel (m)
H_stat = xlsread('Experimental Data.xlsx','Sheet1','G2:G10')*in2m;%Manometer height of static pressure inside tunnel (m)
T = xlsread('Experimental Data.xlsx','Sheet1','H2:H10')+273.15; %Temperature inside tunnel (degK)

%%%Data Processing%%%%
%%%%%%%%%%%%%%%%%%%%%%

%Pressures
Pa = -rho_f*g*sind(theta_m)*((Ha-Ha(1))-(Href-Href(1)))+P_ref;% (Pa)
Pe = -rho_f*g*sind(theta_m)*((He-He(1))-(Href-Href(1)))+P_ref;% (Pa)
Pstat = -rho_f*g*sind(theta_m)*((H_stat-H_stat(1))-(Href-Href(1)))+P_ref;% (Pa)
Ptot = -rho_f*g*sind(theta_m)*((H_tot-H_tot(1))-(Href-Href(1)))+P_ref;% (Pa)

%Density @ Test section 
rho = Pstat./(R.*(T));

%Dynamic Pressures 
dP_ae=Pa-Pe; %Pressure differential from points A to E (linearly related to dP_test)
dP_test=Ptot-Pstat; %Dynamic Pressure @ test section 

%Test Section Velocity
v_test = sqrt(2.*dP_test./rho);% (m/s)

%Wind Tunnel calibration, K 
K = sum(dP_test)/sum(dP_ae); 
fprintf('Wind Tunnel Calibration constant: %f\n',K);
q_tfit = K*dP_ae; %Linear regression / equation relating dP_ae to dP_test

%Motor Speed vs. Flow velocity in test section  
b = sum(v_test)/sum(f_mot); 
V_test_mot = b*(f_mot); %Estimate of the velocity in the test sectio given f_mot


%%%Plots 
figure(1)
title(sprintf('Wind Tunnel Calibration, K = %2.5f',K)); hold on
scatter(dP_ae,dP_test,'d');
plot(dP_ae, q_tfit);
ylabel('q_{T} = .5\rhoV^{2}');
xlabel('\DeltaP = P_{a}-P_{e}');
legend('Experimental Data','Linear Regression','Location','northwest');

figure(2)
title(sprintf('V_{Test} = %2.5f*( f_{motor} )',b));hold on
scatter(f_mot,v_test,'d'); hold on
plot(f_mot,V_test_mot);
xlabel('Motor Speed (Hz)');
ylabel('Test Section Velocity (m/s)');

