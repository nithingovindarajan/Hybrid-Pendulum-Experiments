clc
clear all
close all

global g l m
global theta_left theta_right dp_left dp_right
global omegalist tlist
global H V T
global Pcrit Hmax

% pendulum parameters
g = 9.81;
l = 10;
m = 1;

% discrete part: momentum change
theta_left  = -pi/3; 
theta_right = pi/3;
dp_left = 1;
dp_right = -1;

% Hamiltonian function
H = @(theta, omega)(0.5*m *l^2*omega.^2 - m*g*l*cos(theta) +m *g*l);
% Potential function
V = @(theta)( m*g*l*(1-cos(theta)) );
% Kinetic function
T = @(omega)(0.5*m^l^2* omega.^2);

[omegalist,tlist] = computeweights_max(max(dp_left,dp_right));

% Some important constants
Pcrit = V(theta_left);
Hmax = H(pi,0);
omega_crit = sqrt((Hmax - Pcrit)/(0.5*m *l^2))

[THETA0, OMEGA0] = meshgrid(-pi:0.005*pi:pi, -3:0.005:3);
Htimeavg = zeros(size(THETA0));
for j= 1:length(Htimeavg(:))
    Htimeavg(j) = computeavgHam( THETA0(j), OMEGA0(j) );
end

%%
[ theta,omega,t ] = EllipticSolutions( 1, -pi/3, 1 );
omega(theta>=pi/3) = NaN; 
omega(theta<=-pi/3) = NaN;
[ theta2,omega2,t ] = EllipticSolutions( 1, -pi/3, 0 );

figure(3)
contourf(THETA0, OMEGA0, Htimeavg ,1000,'LineStyle','None')
caxis([66 70])
xlabel('\theta'); ylabel('p')
colormap jet;
colorbar
hold on
plot([theta_left, theta_left], [-1, 1], 'k','LineWidth',1.5)
plot([theta_right, theta_right], [-1, 1], 'k','LineWidth',1.5)
plot(theta,omega,'k','LineWidth',1.5)
plot(theta2,omega2,'k','LineWidth',1.5)

figure(4)
contourf(THETA0, OMEGA0, Htimeavg ,1000,'LineStyle','None')
caxis([66 70])
xlabel('\theta'); ylabel('p')
colormap jet;
colorbar
hold on
plot([theta_left, theta_left], [-1, 1], 'k','LineWidth',2)
plot([theta_right, theta_right], [-1, 1], 'k','LineWidth',2)
plot(theta,omega,'k','LineWidth',2)
plot(theta2,omega2,'k','LineWidth',2)
axis([0.5 1.5 0.5 1.5])

