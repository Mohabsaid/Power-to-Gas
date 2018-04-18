clc
clear
R = 8.314;
F = 96485.33289;
T = 333;
i = linspace(0,1.2);
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
segma_B = ((eta_B-eta_B0).^1.5)*(349.8/(1+segma))*exp((-E_m/R)*((1/T)-(1/298)))*(1/(18*gama))*Beta;
Eta_B = i.*(L_B/segma_B);
% open  circuit voltage calculation %
V_0 = 1.229-(8.46e-4*(T-298));
% exchange curent dinesty
m_Ma = 1e-3;
m_Mc = 0.3e-3;
rho_ma = 22.56;
rho_mc = 21.45;
d_ma = 2.9;
d_mc = 2.7;
lamda_ma = 0.75*m_Ma*(6/(rho_ma*d_ma));
lamda_mc = 0.75*m_Mc*(6/(rho_mc*d_mc));
i_a0ref = 5e-12;
i_c0ref = 1e-3;
E_a = 76;
E_c = 4.3;
i_c0 = lamda_mc*exp(-1*(E_c/R)*((1/T)/(1/298)));
i_a0 = lamda_ma*exp(-1*(E_a/R)*((1/T)/(1/298)));
% cathod overpotentiol %
B_c =.5;
v_c = -1;
n_c = i/i_c0;
m_c = 1-(i/0.000033);
eta_c = ((R*T)/(B_c*v_c*F)).*asinh(.5*(n_c./m_c));
% anode overpotential %
B_a =.5;
v_a = 3;
n_a = i/i_a0;
m_a = 1-(i/2);
eta_a = ((R*T)/(B_a*v_a*F)).*asinh(.5*(n_a./m_a));
% overall potential
V = V_0 + eta_a - eta_c + Eta_B;
plot(i,V)
xlim([0 1.4]);
xlabel('curent denisty');
ylabel('voltage');
grid on
hold on
%H2 out
A = 1;
N = (i.*A)/(2*F);
yyaxis right
ylabel('hydrogen generated');
plot(i,N)
legend('iV curve','hydrogen')
hold off