%%%Lab #2 Code
%%%Lab Section: Wednesdays at 3
%%%Lab group #1
%%%written by: Jake Falck

%%%Outputs%%%
%%Calculated Values: 
    
%%Plots: 
    %%Pressure change vs. Dynamic pressure
        %%plot the linear regression line of the data and find K.
        %%K=qt/delta_p
    %%test section velocity vs. motor speed 
    %%Plot actual points, plot linear regression line of experimental
    %%data,find the equation of the linear regression
    %%%Constants
g = 32.2 %gravity (ft/s^2)
rho = 0.0023769 % density of air(slugs/ft^2)
theta_m = 17.7 %deg

%%%Imports  Experiment Data from Excel Sheet
mot_speed = xlsread('Experimental Data.xlsx','Sheet1','B2:B10');
Href = xlsread('Experimental Data.xlsx','Sheet1','C2:C10');
Href = xlsread('Experimental Data.xlsx','Sheet1','D2:D10');
Ha = xlsread('Experimental Data.xlsx','Sheet1','E2:E10');
He = xlsread('Experimental Data.xlsx','Sheet1','F2:F10');
Htot = xlsread('Experimental Data.xlsx','Sheet1','G2:G10');
Hstat = xlsread('Experimental Data.xlsx','Sheet1','H2:H10');

%%%Data Processing
dp_A = -rho*g*sind(theta_m)*((Ha-Ha(1))-(Href-Href(1)))
% dp_E = 
% dp_tot = 
% dp_stat = 

% q_A = 
% q_E = 
% q_tot =
% q_stat = 

% v_A
% v_E
% v_test 



