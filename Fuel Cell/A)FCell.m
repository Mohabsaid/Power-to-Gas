clc; clear;clf;
%Calculating the Voltage Losses for a Polarization Curve
% UnitSystem SI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%delta_H = input('delta_H = ')
%delta_S = input('delta_S = ')
%delta_G = delta_H - T*delta_S
%Er =-delta_G/(2*F)  
%Current_Density = 0.8  %[A/cm^2]
%V_cell = 0.8 %Voltage for each cell
Power = input('Required power in W = ')
%Power = 2500  %Required power
Volt = input('Required Voltage in Volt = ')
%Volt= 230    %Required Voltage
R = input ('Ideal gas constant(R)in J/molK = ')
%R = 8.314; % Ideal gas constant (J/molK)
F = input ('Faraday’s constant = ')
%F = 96487; % Faraday’s constant (Coulombs)
Tc = input ('Temperature in degrees C = ')
%Tc = 80; % Temperature in degrees C
P_H2 = input ('Hydrogen pressure in atm = ')
%P_H2 = 3; % Hydrogen pressure in atm
P_air = input ('Air pressure in atm = ')
%P_air = 3; % Air pressure in atm
r = input ('Internal Resistance in(Ohm-cm^2) = ')
%r = 0.19; % Internal Resistance (Ohm-cm^2)
Alpha = input ('charge Transfer coefficient = ')
%Alpha = 0.5; % Transfer coefficient
Alpha1 = input ('Amplification constant = ')
%Alpha1 = 0.085; % Amplifi cation constant
io = input ('Exchange Current Density (A/cm^2) = ')
%io = 10^-6.912 ; % Exchange Current Density (A/cm^2)
il = input ('Limiting current density (A/cm2) = ')
%il = 1.4; % Limiting current density (A/cm2)
Gf_liq = input ('Gibbs function in liquid form (J/mol) = ')
%Gf_liq = -228170; % Gibbs function in liquid form (J/mol)
k = input ('Constant k used in mass transport = ')
%k = 1.1; % Cons3tant k used in mass transport
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert degrees C to K
Tk = Tc + 273.15;
% Create loop for current
loop = 1;
i = 0;
for N = 0:150
i = i + 0.01
% Calculation of Partial Pressures
% Calculation of saturation pressure of water
x = -2.1794 + 0.02953 .*Tc-9.1837 .*(10.^-5) .*(Tc.^2) + 1.4454 .*(10.^-7) .*(Tc.^3);
P_H2O = (10.^x)
% Calculation of partial pressure of hydrogen
pp_H2 = 0.5 .*((P_H2)./(exp(1.653 .*i./(Tk.^1.334)))-P_H2O)
% Calculation of partial pressure of oxygen
pp_O2 = (P_air./exp(4.192 .*i/(Tk.^1.334)))-P_H2O
% Activation Losses
b = R .*Tk./(2 .*Alpha .*F);
V_act = -b .*log(i./io) % Tafel equation
% Ohmic Losses
V_ohmic = -(i .*r)
% Mass Transport Losses
term = (1-(i./il));
if term > 0
V_conc = Alpha1 .*(i.^k) .*log(1-(i./il))
else
V_conc = 0
end
%% % Calculation of Nernst voltage
E_nernst = -Gf_liq./(2 .*F) - ((R .*Tk) .*log(P_H2O./(pp_H2 .*(pp_O2.^0.5))))./(2 .*F)
%% 
% Calculation of output voltage
V_out = E_nernst + V_ohmic + V_act + V_conc
if term < 0
V_conc = 0;
break
end
if V_out < 0
V_out = 0;
break
end
figure(1)
title('Fuel cell polarization curve')
xlabel('Current density (A/cm^2)');
ylabel('Output voltage (Volts)');
plot(i,V_out,'*')
grid on
hold on
disp(V_out)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V_cell = input('Voltage for each cell from graph = ')
Current_Density =input('Current_Density from graph = ')
N_cells = Volt/V_cell
Current= Power/(V_cell*N_cells)
A_cell = Current/Current_Density
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
loop = 1;
I = 0;
for M = 0:150
I = I + 0.01;
% Calculation of Partial Pressures
% Calculation of saturation pressure of water
x = -2.1794 + 0.02953 .*Tc-9.1837 .*(10.^-5) .*(Tc.^2) + 1.4454 .*(10.^-7) .*(Tc.^3);
P_H2O = (10.^x)
% Calculation of partial pressure of hydrogen
pp_H2 = 0.5 .*((P_H2)./(exp(1.653 .*I./(Tk.^1.334)))-P_H2O)
% Calculation of partial pressure of oxygen
pp_O2 = (P_air./exp(4.192 .*I/(Tk.^1.334)))-P_H2O
% Activation Losses
b = R .*Tk./(2 .*Alpha .*F);
V_act = -b .*log(I./io); % Tafel equation
% Ohmic Losses
V_ohmic = -(I .*r);
% Mass Transport Losses
term = (1-(I./il));
if term > 0
V_conc = Alpha1 .*(I.^k) .*log(1-(I./il));
else
V_conc = 0;
end
% Calculation of Nernst voltage
E_nernst = -Gf_liq./(2 .*F) - ((R .*Tk) .*log(P_H2O./(pp_H2 .*(pp_O2.^0.5))))./(2 .*F)
% Calculation of output voltage
V_out = E_nernst + V_ohmic + V_act + V_conc;
if term < 0
V_conc = 0;
break
end
if V_out < 0
V_out = 0;
break
end
P_out = N_cells .*V_out .*I .*A_cell;
figure(2)
title('Fuel cell power at the specified No. of Cells')
xlabel('Current density (A/cm^2)');
ylabel('Power(Watts)');
plot(I,P_out,'*');
grid on
hold on
disp(P_out);
end
