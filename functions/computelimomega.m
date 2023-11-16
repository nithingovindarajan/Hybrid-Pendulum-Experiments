function [ omegas,q,theta ] = computelimomega( theta0, omega0 )
    global g l m
    global theta_left theta_right dp_left dp_right
    global H V T
    global Pcrit Hmax

    % Map theta to unit circle
    omegas = zeros(2,1);

    % determine if q0 q1 q2 q3
    if ( theta0 == theta_left && omega0>0 ) 
        q0 = 1;
    elseif ( theta0 == theta_right && omega0<0 )
        q0 = 2;
    elseif ( H(theta0, omega0) == Hmax )
        q0 = 3;
    else
        q0 = 0; 
    end

    % Find convergent sequence
    theta = theta0;
    omega = omega0;
    q = q0;
    qprev = 0;

    i = 0;
    while  i < 100
        if q == 0  
            if H(theta,omega) < Pcrit
            break;
            elseif ( theta<theta_left && omega <= 0 && H(theta,omega) == Hmax )  ||  ( theta>theta_right && omega >= 0 && H(theta,omega) == Hmax ) 
                q = 3;
                theta = pi;
                omega = 0;
                omega_prev = 0;
                break;
            elseif (theta< theta_left && omega <= 0 && H(theta,omega) > Hmax)  ||  (omega <= 0 && H(theta,omega) > Pcrit && theta> theta_left) || (theta> theta_right && omega >= 0 && H(theta,omega) < Hmax)
                q = 1;
                omega = -sqrt( (H(theta, omega) - V(theta_left)) / (0.5*m*l^2) )    + dp_left;
                theta = theta_left;
            
            elseif (theta> theta_right && omega >= 0 && H(theta,omega) > Hmax) ||  (omega >= 0 && H(theta,omega) > Pcrit && theta< theta_right) || (theta< theta_left && omega <= 0 && H(theta,omega) < Hmax)
                q = 2;
                omega = sqrt( (H(theta, omega) - V(theta_right) )/ (0.5*m*l^2) ) + dp_right;
                theta = theta_right;
            end    
        elseif q == 1;
            if omega < 0 && H(theta,omega) == Hmax
                q = 3;
                theta = pi;
                omega = 0;
                omega_prev = 0;
                break;
            elseif omega<0 && H(theta,omega) > Hmax
                q = 1;
                omega = -sqrt( (H(theta, omega) - V(theta_left)) / (0.5*m*l^2) )  +  dp_left;
                theta = theta_left;    
            elseif (omega<0 && H(theta,omega) < Hmax) || omega>=0 
                q = 2;
                qprev = 1;
                omega = sqrt( (H(theta, omega) - V(theta_right)) / (0.5*m*l^2) )    + dp_right;
                theta = theta_right;
                break;
            end
        elseif q == 2;
            if omega > 0 && H(theta,omega) == Hmax
                q = 3;
                theta = pi;
                omega = 0;
                omega_prev = 0;
                break;
            elseif omega>0 && H(theta,omega) > Hmax
                q = 2;
                omega = sqrt( (H(theta, omega) - V(theta_right)) / (0.5*m*l^2) ) + dp_right;
                theta = theta_right;
            elseif (omega>0 && H(theta,omega) < Hmax) || omega<=0 
                q = 1;
                qprev = 2;
                omega = -sqrt( (H(theta, omega) - V(theta_left)) / (0.5*m*l^2) ) +  dp_left;
                theta = theta_left;
                break;
            end 
        elseif q == 3
            break;
        end
    i = i +1;
    end

    % Compute time average
    if q == 0
        avgHam = H(theta, omega);
        omega_prev = omega;
        omegas = [omega; omega_prev];
    elseif q == 3
        avgHam = H(theta, omega);
        omega_prev = 0;
        omegas = [omega; omega_prev];
    elseif qprev ~= 0
        [avgHam,omegas] =  avg_nontrivialcase(q, theta, omega);
    else
        avgHam = NaN;
        disp('asymptotic part is not reached')
    end

end

function [ avgHam, omegas ] = avg_nontrivialcase( q, theta, omega )
    global g l m
    global theta_left theta_right dp_left dp_right
    global H V T
    global Pcrit Hmax

    for i = 1:50
        omega_prev = omega;   
        if q == 1
            q = 2;
            omega = -sqrt( (H(theta, omega) - V(theta_right)) / (0.5*m*l^2) )+ dp_left;
            theta = theta_right;   
        elseif  q == 2;
            q = 1;
            omega = sqrt( (H(theta, omega) - V(theta_left)) / (0.5*m*l^2) ) + dp_right;
            theta = theta_left;
        end
    end
    avgHam =( H(omega,theta_left) + H(omega_prev, theta_right) ) /2;
    omegas = [omega; omega_prev];
end
