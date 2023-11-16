function [ u, Thalfperiod ] = computemaps()
    global mu1 mu2 k theta_kick

    f = @(t,y,k)([ mu1*y(2) ;
                - (mu2^2/mu1) * sin(y(1)) - k*y(2) ]);
    p = 0:0.005:1;          
    p_plus = zeros(size(p));          
    Thalfperiod = zeros(size(p));

    % Euler method stepsize h=0.01
    for i = 1:length(p)
        [ p_plus(i), Thalfperiod(i)] = eulersolver(f, p(i), theta_kick,k, 0.001);
    end  
    u = @(p_interp)(interp1(p,1-abs(p_plus),p_interp));
    Thalfperiod = @(p_interp)(interp1(p,Thalfperiod,p_interp));
end

