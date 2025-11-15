% Calculate Snatch Force on Shock Cord deploying parachute at certain altitude.
% Code Creator: Hrsh Shah
% hshah2023@my.fit.edu
% Date: 1/26/2025

% Inputs
speed = 20; % m/s
mass = 7; % kg
Cd = 2.2; % Drag coefficient
diameter = 1.21; % Parachute diameter in meters
density = 0.004; % Air density in kg/m^3

% Calculations
p_area = 0.25 * pi * diameter^2; % Parachute area in m^2
drag = 0.5 * density * speed^2 * p_area * Cd; % Drag force in Newtons
drag_lbf = drag * 0.224809; % Convert force to pounds-force (1 N = 0.224809 lbf)

% Output
disp(['The drag force is: ', num2str(drag), ' N']);
disp(['The drag force in lbf is: ', num2str(drag_lbf), ' lbf']);