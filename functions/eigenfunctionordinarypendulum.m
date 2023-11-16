function [ Eigfuncmod, sigma ] = eigenfunctionordinarypendulum(mu1,mu2,k,theta_kick)
   A = [0 ,   1;
      -1,  -k];
   [V, D] = eig(A);
   Vinv = V^(-1);
   lambda = D(1,1);
   sigma = real(lambda);
   theta0 = -1.1*theta_kick:(0.03*pi):1.1*theta_kick;
   omega0 = -1.1*1.4:.1:1.1*1.4;
   [THETA0, OMEGA0] = meshgrid(theta0, omega0);
   f = @(t,y)([mu1*y(2);
               -(mu2^2/mu1)*sin(y(1))-k*y(2)]);
   s1mod = zeros(size(THETA0));
         
   for dd = 1:length(theta0)
      dd
      for s=1:length(omega0)
         x0 = [THETA0(s,dd) OMEGA0(s,dd)];
         [T,Y] = ode45(f,[0 150],x0);
         ztend = (1/sqrt(2))*norm(Vinv*transpose(Y(end,:)));
         s1mod(s,dd) = exp(-sigma*T(end))*ztend;
      end
   end
   Eigfuncmod= @(theta_interp, omega_interp)(interp2(THETA0,OMEGA0,s1mod,theta_interp,omega_interp));
end

