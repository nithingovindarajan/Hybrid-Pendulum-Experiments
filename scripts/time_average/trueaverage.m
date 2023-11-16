clc; clear all; close all

global g l m
global theta_left theta_right dp_left dp_right
global H V T
global Pcrit Hmax

%  pendulum parameters
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


% Some important constants
Pcrit = V(theta_left);
Hmax = H(pi,0);
[omegalist,tlist] = computeweights_max(max(dp_left,dp_right));
%
[THETA0, OMEGA0] = meshgrid(-pi:0.05*pi:pi, -3:0.05:3);
[M,N] = size(THETA0);
Htimeavg = zeros(size(THETA0));
taus = zeros(M,N,2);
omegas = zeros(M,N,2);
qmat = zeros(M,N);
thetamat = zeros(M,N);
baseper = 2*pi*sqrt(g/l);

for jj= 1:M
    for kk = 1:N
        [omegas(jj,kk,:),qmat(jj,kk),thetamat(jj,kk)] = computelimomega( THETA0(jj,kk), OMEGA0(jj,kk) );
        if (qmat(jj,kk) == 0) || (qmat(jj,kk) == 3)
            Htimeavg(jj,kk) = H(omegas(jj,kk,1),thetamat(jj,kk));
        else
            for mm = 1:2
                inter = true;
                o1 = abs(omegas(jj,kk,mm));
                ocomp = omegalist-o1;
                ind = 1;
                if inter ~= false
                    per = interp1(Yuse(ind-1:ind),T1(ind-1:ind),0);
                    taus(jj,kk,mm) = per;
                end
            end
            H1 = H(omegas(jj,kk,1),theta_left);
            H2 = H(omegas(jj,kk,2),theta_left);
            Htimeavg(jj,kk) = (H1*taus(jj,kk,1)+H2*taus(jj,kk,2))/(taus(jj,kk,1)+taus(jj,kk,2));
        end
    end
end

figure(3)
contourf(THETA0, OMEGA0, Htimeavg ,100,'LineStyle','None')
title('Time average of Observable')
caxis([60 100])
colormap jet
xlabel('\theta'); ylabel('\omega')
colorbar
