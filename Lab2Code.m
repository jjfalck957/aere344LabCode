%%%Lab #2 Code
%%%Lab Section: Wednesdays at 3
%%%Lab group #1
%%%written by: Jake Falck
close all;clear;clc
%%%Outputs%%%
%%Calculated Values: 
    
%%Plots: 
    %%Pressure change vs. Dynamic pressure
        %%plot the linear regression line of the data and find K.
        %%K=qt/delta_p
    %%test section velocity vs. motor speed 
    %%Plot actual points, plot linear regression line of experimental
    %%data,find the equation of the linear regression
   
   %%Notes: 
    
%%%Constants
format long
g = 9.81; %gravity (m/s^2)
theta_m = 17.7; % deg
P_ref = 1000*100;%hPa -> Pa 
R=287.05; % J/(kg*K)
rho_f = 997; %density of water (kg/m^3)
in2m = .0254; %conversion factor from inch to meter

%%%Importing Experiment Data from Excel Sheet
mot_speed = xlsread('Experimental Data.xlsx','Sheet1','B2:B10');% unit: Hz
Href = xlsread('Experimental Data.xlsx','Sheet1','C2:C10')*in2m;% unit: m 
Ha = xlsread('Experimental Data.xlsx','Sheet1','D2:D10')*in2m;% unit: m
He = xlsread('Experimental Data.xlsx','Sheet1','E2:E10')*in2m;% unit: m
H_tot = xlsread('Experimental Data.xlsx','Sheet1','F2:F10')*in2m;% unit: m
H_stat = xlsread('Experimental Data.xlsx','Sheet1','G2:G10')*in2m; % unit: m
T = xlsread('Experimental Data.xlsx','Sheet1','H2:H10')+273.15; %Temp of tunnel, K

%%%Data Processing%%%%
%%%%%%%%%%%%%%%%%%%%%%

%Pressures
Pa = -rho_f*g*sind(theta_m)*((Ha-Ha(1))-(Href-Href(1)))+P_ref;
Pe = -rho_f*g*sind(theta_m)*((He-He(1))-(Href-Href(1)))+P_ref;
Pstat = -rho_f*g*sind(theta_m)*((H_stat-H_stat(1))-(Href-Href(1)))+P_ref;
Ptot = -rho_f*g*sind(theta_m)*((H_tot-H_tot(1))-(Href-Href(1)))+P_ref;

%Density @ Test section 
rho = Pstat./(R.*(T));

%Dynamic Pressures 
dP_ae=Pa-Pe; %Pressure differential from A to E 
dP_test=Ptot-Pstat; %Dynamic Pressure @ test section 

%Test Section Velocity
v_test = sqrt(2.*dP_test./rho)

%Wind Tunnel calibration, K 
K = sum(dP_test)/sum(dP_ae); 
fprintf('Wind Tunnel Calibration constant: %f\n',K);
q_tfit = K*dP_ae;

%Motor Speed vs. Flow velocity in test section  
b = sum(v_test)/sum(mot_speed);
linfit = b*mot_speed;

%%%Plots 
figure(1)
title('Wind Tunnel Calibration, K');hold on
scatter(dP_ae,dP_test,'d');
plot(dP_ae, q_tfit);
ylabel('q_{T} = .5\rhoV^{2}');
xlabel('\DeltaP = P_{a}-P_{e}');
legend('Experimental Data','Linear Regression','Location','northwest');

figure(2)
title('Motor Speed vs. Test Section Velocity');hold on
scatter(mot_speed,v_test,'d'); hold on
plot(mot_speed,linfit);
xlabel('Motor Speed (Hz)');
ylabel('Test Section Velocity (m/s)');

















