clc
clear
R = 8.314;
F = 96485.33289;
T = 333;
i = linspace(0,2);
% calculating the ohmic resestance %
L_B = 175e-4;
E_m = 14;
segma = 1.65;
r = 537/18;
gama = 20;
gama_0 = 1.8;
eta_B = gama/(gama+r);
eta_B0 = gama_0/(gama_0+r);
K_a = exp((-523000/R)*((1/T)-(1/298)));
Beta = ((gama+1)-sqrt(((gama+1)^2)-(4*gama*(1-(1/K_a)))))/(2*(1-(1/K_a)));
segma_B = ((eta_B-eta_B0).^1.5)*(349.8/(1+gama))*exp((-E_m/R)*((1/T)-(1/298)))*(1/182)*Beta;
eta_B = i*(L_B/segma_B);
% open  circuit voltage calculation %
V_0 = 1.229-(8.46e-4*(T-298));
% cathod overpotentiol %
B_c =.5;
v_c = -1;
i_c0 = 1e-3;
n_c = i/i_c0;
m_c = 1-(i/2);
eta_c = ((R*T)/(B_c*v_c*F)).*asinh(.5*(n_c./m_c));
% anode overpotential %
B_a =.5;
v_a = 3;
i_a0 = 5e-12;
n_a = i/i_a0;
m_a = 1-(i/2);
eta_a = ((R*T)/(B_a*v_a*F)).*asinh(.5*(n_a./m_a));
% overall potential
V = V_0 + eta_a - eta_c + eta_B;
plot(i,V)
grid on