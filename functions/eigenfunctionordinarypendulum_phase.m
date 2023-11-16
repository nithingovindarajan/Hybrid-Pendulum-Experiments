function [ Eigfuncnorm, eta ] = eigenfunctionordinarypendulum_phase(mu1,mu2,k,theta_kick)
     A = [0 ,   1;
          -1,  -k]; 
     [V, D] = eig(A);
     Vinv = V^(-1);
     lambda = D(1,1);
     eta = imag(lambda);
     theta0 = -1.1*theta_kick:(0.005*pi):1.1*theta_kick;
     omega0 = -1.1*1.4:.05:1.1*1.4;
     [THETA0, OMEGA0] = meshgrid(theta0, omega0);
     f = @(t,y)([mu1*y(2);
               -(mu2^2/mu1)*sin(y(1))-k*y(2)]);
     s1phase = zeros(size(THETA0));

     for dd = 1:length(theta0)
          display([num2str(dd), ' out of ', num2str(length(theta0))])
          for s=1:length(omega0)
               x0 = [THETA0(s,dd) OMEGA0(s,dd)];
               [T,Y] = ode45(f,[0 100],x0);
               z1tend = 1/sqrt(2)*norm(Vinv*transpose(Y(end,:)));
               z2tend =([1 0]* Vinv*transpose(Y(end,:))  ) /z1tend;
               s1phase(s,dd) = angle( exp(1i*eta*T(end))*z2tend );
          end      
     end
     Eigfuncnorm= @(theta_interp, omega_interp)(interp2(THETA0,OMEGA0,s1phase,theta_interp,omega_interp));
end

