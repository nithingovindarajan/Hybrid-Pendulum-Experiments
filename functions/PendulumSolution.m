function [ theta,omega,t,T ] = PendulumSolution( wn,theta0,w0,kick_angle)
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
        t = 0:0.001:T;  % single period discretized
        [sn,cn,~]=ellipj(wn*t,k);   % elliptic functions
        theta = 2 * asin(k * sn);   % angle
        omega  = 2*wn*k *cn;         % velocity
        i_kick = find(theta>kick_angle,1,'first')-1;
        t = t - t(i_kick);
        t = T-mod(t,T); % time = time to reach the kick angle
    else
        kappa = 1/k;
        T = 2*kappa *ellipke(kappa^2)/wn; % the period
        t = 0:0.001:T/2+.005;  % single period discretized
        [sn,~,dn]=ellipj(wn*t/kappa,kappa^2);   % elliptic functions
        theta = 2 * asin(sn);   % angle
        omega  = 2*wn*dn/kappa;         % velocity
        theta = [-fliplr(theta(2:end)),theta];
        omega = [fliplr(omega(2:end)),omega];
        t = [-fliplr(t(2:end)),t];
        i_kick = find(theta>kick_angle,1,'first')-1;
        t = t - t(i_kick);
        t = T-mod(t,T); % time = time to reach the kick angle
    end
    H = .25*omega.^2/wn^2 + sin(theta/2).^2; %energy

end

