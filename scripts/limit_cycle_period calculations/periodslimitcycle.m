clc
clear all
close all

%  pendulum parameters
global g l m
g = 10;
l = 10;
m = 1;

global H 
% Hamiltonian function
H = @(theta, omega)(0.5*m *l^2*omega.^2 - m*g*l*cos(theta) +m *g*l);

figure
hold on
[p1,Tperiodlimitcycle] = computeweights(1, pi/10);
plot(p1, Tperiodlimitcycle, 'k')
[p1,Tperiodlimitcycle] = computeweights(2, pi/10);
plot(p1, Tperiodlimitcycle,'k:')
[p1,Tperiodlimitcycle] = computeweights(3, pi/10);
plot(p1, Tperiodlimitcycle,'k--')
[p1,Tperiodlimitcycle] = computeweights(4, pi/10);
plot(p1, Tperiodlimitcycle,'k-.')
legend('\mu_1 = 1', '\mu_1 = 2', '\mu_1 = 3', '\mu_1 = 4','Location','northoutside','Orientation','horizontal')
xlabel('p_1'); ylabel('P[{p_1}]')

figure
hold on
[p1,Tperiodlimitcycle] = computeweights(2, pi/5);
plot(p1, Tperiodlimitcycle, 'k')
[p1,Tperiodlimitcycle] = computeweights(2, pi/4);
plot(p1, Tperiodlimitcycle,'k:')
[p1,Tperiodlimitcycle] = computeweights(2, pi/3);
plot(p1, Tperiodlimitcycle,'k--')
[p1,Tperiodlimitcycle] = computeweights(2, pi/2);
plot(p1, Tperiodlimitcycle,'k-.')
legend('\theta^* = \pi/5', '\theta^* = \pi/4', '\theta^* = \pi/3', '\theta^* = \pi/2','Location','northoutside','Orientation','horizontal')
xlabel('p_1'); ylabel('P[{p_1}]')