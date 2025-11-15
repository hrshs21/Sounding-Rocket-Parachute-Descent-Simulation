%% Sounding Rocket Descent Simulation
% Created by Hrsh Shah
% Last Edited 10/26/2025

open_system('ParachuteSimV1.slx');

% Initial Parameters

headingInitial    = 0;     % deg
lattitude         = 40.861903;    
longitude         = -119.113646;
dayOfYear         = 298;   % date in # of days from 01/01/xxxx
secOfDayUTC       = 24000; % time in seconds from 00:00:00
year              = 2025;

northwardVelocity = 30; % m/s
eastwardVelocity  = 30; % m/s

area        = 1.17;     % m^2
mass        = 45;       % kg
velocity    = 100;      % m/s (used for cd)            
g           = 9.81;     % m/s^2                      
rho         = 1.229;    % kg/m^3 density @ sea level                    
Cd          = 2*mass*g/(rho*(velocity^2)*area);

hOpening    = 100000;   % m   

XeInitial          = 0;  
YeInitial          = 0;   
ZeInitial          = 100000;   
apogeeHeight       = ZeInitial;

% UInitialKMPH       = 235;     
% UInitialMPS        = 100;
% VInitialKMPH       = 0;    
% VInitialMPS        = 100; 
% WInitialKMPH       = 0;     
% WInitialMPS        = convvel(WInitialKMPH,'km/h','m/s');

% Wind Gust Possibility
windDisturbance = true;
if windDisturbance == true
    windSeed = randi([200 1000],1); %% wind gust chance ([startTime endTime] 1)
end

simResults = sim('ParachuteSimV1.slx');

% 3D Figure
figure;
plot3(simResults.yout{1}.Values.Data(:,2),simResults.yout{1}.Values.Data(:,1),...
      simResults.yout{1}.Values.Data(:,3));
zlim([0 max(simResults.yout{1}.Values.Data(:,3))]);
grid on;
xlabel('Xe (m)');
ylabel('Ye (m)');
zlabel('Ze (m)');

% Satellite Imagery Figure
figure;
llaPosition = flat2lla([simResults.yout{1}.Values.Data(:,1) ...
                        simResults.yout{1}.Values.Data(:,2) ...
                        simResults.yout{1}.Values.Data(:,3)],...
                     [lattitude, longitude], headingInitial,0);
geoplot(llaPosition(:,1), llaPosition(:,2),'r','LineWidth',2)
geolimits([min(llaPosition(:,1))-0.01 max(llaPosition(:,1))+0.01],...
          [min(llaPosition(:,2))-0.01 max(llaPosition(:,2))+0.01])
geobasemap satellite

%% Monte Carlo Simulation

 numSim             = 100;
 windDisturbance    = true;
 gustStartTime      = randi([200 1000],[1 numSim]); 

ZeDeviation        = 5000; % m   
hOpeningDeviation  = 3000; % m
VelocityDeviation   = 15; % m/s

apogeeHeight = ZeDeviation.*randn(numSim,1) + ZeInitial;
openingAltitude =  hOpeningDeviation.*randn(numSim,1) + hOpening;
northVelocityDev = VelocityDeviation.*randn(numSim,1) + northwardVelocity;
eastVelocityDev = VelocityDeviation.*randn(numSim,1) + eastwardVelocity;

in(1:numSim) = Simulink.SimulationInput('ParachuteSimV1');
for simNumber = 1:1:numSim
    in(simNumber) = in(simNumber).setVariable('hOpening',openingAltitude(simNumber));
    in(simNumber) = in(simNumber).setVariable('apogeeHeight',apogeeHeight(simNumber));
    in(simNumber) = in(simNumber).setVariable('windSeed',gustStartTime(simNumber));
    in(simNumber) = in(simNumber).setVariable('northwardVelocity',northVelocityDev(simNumber));
    in(simNumber) = in(simNumber).setVariable('eastwardVelocity',eastVelocityDev(simNumber));
    
end
simResults = parsim(in, 'UseFastRestart','on','ShowSimulationManager', 'on',...
                    'ShowProgress','on','TransferBaseWorkspaceVariables','on');
%% Monte Carlo Results


figure;
for simNumber = 1:1:numSim
    plot3(simResults(1,simNumber).yout{1}.Values.Data(:,1),...
          simResults(1,simNumber).yout{1}.Values.Data(:,2),...
          simResults(1,simNumber).yout{1}.Values.Data(:,3));
    hold on;
end
grid on;
title(["Monte Carlo Simulation Results for Variations in the";...
       "Wind Disturbance, Earth-Body Velocity and Apogee Altitude"]);
xlabel('Xe (m)');
ylabel('Ye (m)');
zlabel('Ze (m)');

figure;
gx = geoaxes;
for simNumber = 1:1:numSim
    llaPosition = flat2lla([simResults(1,simNumber).yout{1}.Values.Data(:,1) ...
                            simResults(1,simNumber).yout{1}.Values.Data(:,2) ...
                           -1*simResults(1,simNumber).yout{1}.Values.Data(:,3)],...
                           [lattitude, longitude], headingInitial,0);
    geoplot(gx,llaPosition(:,1), llaPosition(:,2),'LineWidth',2)
    geolimits(gx,[min(llaPosition(:,1,:))-0.01 max(llaPosition(:,1,:))+0.01],...
                 [min(llaPosition(:,2,:))-0.01 max(llaPosition(:,2,:))+0.01])
    geobasemap(gx,"satellite")
    hold on
end

figure;
gx = geoaxes;
for simNumber = 1:1:numSim
    llaPosition = flat2lla([simResults(1,simNumber).yout{1}.Values.Data(:,1) ...
                            simResults(1,simNumber).yout{1}.Values.Data(:,2) ...
                         -1*simResults(1,simNumber).yout{1}.Values.Data(:,3)],...
                           [lattitude, longitude], headingInitial,0);
    geoplot(gx,llaPosition(:,1), llaPosition(:,2),'LineWidth',2)
    geolimits(gx,[(lattitude+.5) (lattitude-.5)],[(longitude+.5) (longitude-.5)])
    geobasemap(gx,"satellite")
    hold on
end