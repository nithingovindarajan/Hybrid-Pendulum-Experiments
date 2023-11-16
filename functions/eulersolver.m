function [ p0bar,Tkick] = eulersolver(ODEfun, p0, theta_kick,k, h)
    t = 0;
    y = [-theta_kick; p0];

    % integrate freely until angle changes sign
    while y(1)<= 0
        y = y + h*ODEfun(t,y,k); 
        t = t + h;
    end

    % integrate until angle changes sign again (somewhere in between
    % it should have reached theta_kick if sufficient momemtum was there) 
    p0bar = NaN;
    Tkick = NaN;
    while y(1)>= 0
        yprev = y;
        y = y + h*ODEfun(t,y,k); 
        t = t + h;
        if y(1)>theta_kick
            p0bar = (y(2) + yprev(2))/2; 
            Tkick = t-0.5*h;
            break;
        end
    end 
end

