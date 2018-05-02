% Initialization file for demo ssc_lithium_cell_1RC_estim_ini.mdl. Demo
% based on T. Huria, M. Ceraolo, J. Gazzarri, R. Jackey. "High Fidelity
% Electrical Model with Thermal Dependence for Characterization and
% Simulation of High Power Lithium Battery Cells," IEEE International
% Electric Vehicle Conference, March 2012
%
% Copyright 2012 The MathWorks, Inc.


%% Chosen Values

% SOC Lookup Table breakpoints
SOC_LUT = (0:0.1:1)';


%% Known Values

% Battery capacity
% Measured by coulomb counting the discharge curve
Capacity = 27.6250; %Ampere*hours

% Charge deficit at start of data set
% Assumption based on preparation of test
Qe_init = 0; %Ampere*hours


%% Estimated Parameters - Initial starting points before estimation

% Em open-circuit voltage vs SOC
Em = 3.8*ones(size(SOC_LUT)); %Volts

% R0 resistance vs SOC
R0 = 0.01*ones(size(SOC_LUT)); %Ohms

% R1 Resistance vs SOC
R1 = 0.005*ones(size(SOC_LUT)); %Ohms

% C1 Capacitance vs SOC
C1 = 10000*ones(size(SOC_LUT)); %Farads


%% Load Dataset
load('LiBatt_PulseData.mat')

        