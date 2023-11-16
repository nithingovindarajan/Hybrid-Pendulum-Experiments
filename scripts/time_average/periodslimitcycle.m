clc
clear all
close all

%  pendulum parameters
global g l m
g = 10;
l = 10;
m = 1;

% discrete part: momentum change
global theta_left theta_right dp_left dp_right
theta_left  = -pi/10; 
theta_right = pi/10;
dp_left = 1;
dp_right = -1;


global H V T

% Hamiltonian function
H = @(theta, omega)(0.5*m *l^2*omega.^2 - m*g*l*cos(theta) +m *g*l);
% Potential function
V = @(theta)( m*g*l*(1-cos(theta)) );
% Kinetic function
T = @(omega)(0.5*m^l^2* omega.^2);


%Some important constants
global Pcrit Hmax
Pcrit = V(theta_left);
Hmax = H(pi,0);

[omegalist,tlist] = computeweights_max(max(dp_left,dp_right));
Tperiodlimitcycle = tlist'+flipud(tlist');
omegalist = omegalist';

figure
plot(omegalist, Tperiodlimitcycle)
xlabel('p_1'); ylabel('T_{p_1}')  