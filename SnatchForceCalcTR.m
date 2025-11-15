% Calculate Snatch Force on Shock Cord deploying parachute at certain altitude.
% Code Creator: Hrsh Shah
% hshah2023@my.fit.edu
% Date: 1/26/2025

% Inputs
speedFPS    = 65;
speed       = convvel(speedFPS,'ft/s','m/s');
%speed = 20; % m/s

weight      = 16; %lbs
mass        = convmass(weight,'lbm','kg');
%mass       = 7; % kg

Cd          = 1.8; % Drag coefficient

diameterFt  = 5; %Parachute diameter in feet
diameter    = convlength(diameterFt,'ft','m');
%diameter   = 2.1; % Parachute diameter in meters

irisDiamFt  = 1; %feet
irisDiam    = convlength(irisDiamFt,'ft','m');
%irisDiam    = .025; %kg
density     = 1.2; % Air density in kg/m^3

% Calculations
p_area = 0.25 * pi * diameter^2; % Parachute area in m^2
i_area = 0.25 * pi * irisDiam^2; % Parachute area in m^2
p_area = p_area - i_area;
drag = 0.5 * density * speed^2 * p_area * Cd; % Drag force in Newtons
drag_lbf = drag * 0.224809; % Convert force to pounds-force (1 N = 0.224809 lbf)

% Output
disp(['The snatch force is: ', num2str(drag), ' N']);
disp(['The snatch force in lbf is: ', num2str(drag_lbf), ' lbf']);