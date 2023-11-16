function [ p1, Tperiod] = computeweights(omega_kick, theta_kick)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

global g l m
global H 

omega0 = 0:0.05*omega_kick:omega_kick;
Toneside = zeros(size(omega0));
for i = 1:length(omega0)

    E0 = H(theta_kick, omega0(i));
    K0 = 2*E0/(m*l^2) - 2*g/l;
    k0 = 2*g/l;
    Toneside(i) = ( -4*ellipticF(-theta_kick/2, 2*k0/(k0+K0)) ) / sqrt(K0+k0);

end

p1 = (1/omega_kick)*omega0;
Tperiod = Toneside'+flipud(Toneside');

end

