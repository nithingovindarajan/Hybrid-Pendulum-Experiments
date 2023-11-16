function [ Tinit, pinit, getskicked ] = simuntilfirstkick(theta0,p0)
       global mu1 mu2 k theta_kick

       %initialize 
       getskicked = 0;
       pinit = NaN; 
       Tinit = NaN;

       f = @(t,y)([ mu1*y(2) ;
                     - (mu2^2/mu1) * sin(y(1)) - k*y(2) ]);
       h = 0.001;                 
       t = 0;
       y = [theta0;p0];
       if ~getskicked
              while sign(y(1)) == sign(theta0) 
                     yprev = y;
                     y = y + h*f(t,y); 
                     t = t + h;
                     if abs(y(1)) >= theta_kick
                            getskicked = 1;
                            pinit = (y(2) + yprev(2))/2; 
                            Tinit = t-0.5*h;
                            break;
                     end
              end   
       end 
       if ~getskicked
              while sign(y(1)) ~= sign(theta0) 
                     yprev = y;
                     y = y + h*f(t,y); 
                     t = t + h;
                     if abs(y(1))>= theta_kick
                            getskicked = 1;
                            pinit = (y(2) + yprev(2))/2; 
                            Tinit = t-0.5*h;
                            break;
                     end
              end
       end
end



