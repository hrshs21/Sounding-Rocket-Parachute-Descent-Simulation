🚀 Sounding Rocket Descent Simulation (MATLAB/Simulink)

This project simulates the descent and parachute recovery of a sounding rocket from ~100 km altitude. It includes both a single-run descent and a Monte Carlo simulation to evaluate landing dispersion under varying wind and initial conditions.

The simulation is built using MATLAB and Simulink.

✨ Features

Simulates rocket descent from 100,000 m

Parachute deployment at a user-defined altitude

Drag model with adjustable mass, area, Cd

Optional wind gust disturbance

Monte Carlo batch simulation (100 runs)

3D trajectory plots

Geographic ground tracks on satellite maps

📁 Included Files

ParachuteSimV1_Main.m
Main MATLAB script that sets parameters, runs the Simulink model, generates plots, and performs Monte Carlo analysis.

ParachuteSimV1.slx
Simulink model implementing descent dynamics, drag, wind, and environment.

🧪 Monte Carlo Simulation

The Monte Carlo section varies:

Apogee height

Parachute opening altitude

North/East initial velocities

Wind disturbance timing

This produces a spread of descent trajectories and landing locations.

📊 Output Plots

The script automatically creates:

3D descent path

Satellite map ground track

Monte Carlo trajectory cloud

Landing dispersion map

▶️ How to Run

Clone the repository:

git clone https://github.com/yourusername/ParachuteSimV1.git


Open MATLAB and run:

ParachuteSimV1_Main


Ensure ParachuteSimV1.slx is in the same folder.

📝 Notes

Script uses local latitude/longitude and date/time for converting trajectories to geographic coordinates.

Atmospheric density is currently simplified but can be replaced with a higher-fidelity model like NRLMSISE-00.

Parallel Computing Toolbox improves Monte Carlo speed.

Author

Hrsh Shah
Aerospace engineering & recovery subsystems lead (AIAA competition team).
Specializing in high-altitude flight modeling, parachute systems, and Monte Carlo analysis.
