function [ theta,omega,t ] = EllipticSolutions( wn,theta0,w0 )
%ELLIPTICSOLUTIONS : computes the trajctories of the nonlinear pendulum
%over half a period
%-----------------------------------------------------------------------%
% input arguements: 
% wn - natural frequency of the linearized system
% theta0 - initial angle
% w0 - initial angular momentum
%-----------------------------------------------------------------------%
% output arguements:
% t - trajectory time realizations
% theta & omega - angle and momentum at times given by t
    k = sqrt((.25/(wn^2))*w0^2 + sin(theta0/2)^2); % modulus (square of root of energy)

    if k<=1
        T = 4*ellipke(k)/wn; % the period
        t = 0:0.01:T+.01;  % single period discretized
        [sn,cn,~]=ellipj(wn*t,k);   % elliptic functions
        theta = 2 * asin(k * sn);   % angle
        omega  = 2*wn*k *cn;         % velocity
    else
        kappa = 1/k;
        T = 2*kappa *ellipke(kappa)/wn; % the period
        t = 0:0.01:T/2;  % single period discretized
        [sn,~,dn]=ellipj(wn*t/kappa,kappa^2);   % elliptic functions
        theta = 2 * asin(sn);   % angle
        omega  = 2*wn*dn/kappa;         % velocity
    %     omega = omega+(wmax-omega(1));
    end
    H = .25*omega.^2/wn^2 + sin(theta/2).^2; %energy d
end

