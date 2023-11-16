function [ omega0, Toneside ] = computeweights_max(omega_max)
    global g l m
    global theta_left
    global H 

    omega0 = 0:0.01:omega_max;
    theta0 = theta_left*ones(size(omega0));

    Toneside = zeros(size(omega0));
    for i = 1:length(theta0)
        E0 = H(theta0(i), omega0(i));
        K0 = 2*E0/(m*l^2) - 2*g/l;
        k0 = 2*g/l;
        Toneside(i) = ( -4*ellipticF(theta0(i)/2, 2*k0/(k0+K0)) ) / sqrt(K0+k0);
    end
end

