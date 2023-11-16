%% step 1: compute maps
clc; clear all; close all;

g = 10;
l = 10;
global theta_kick
theta_kick = pi/3;

global mu1 mu2 k
mu1 = 1;
mu2 = sqrt(g/l);
k = 0.03;

global u  Thalfperiod
[ u, Thalfperiod ] = computemaps();

figure(1)
hold on;
plot(0:0.001:1, u(0:0.001:1),'k')
plot([0 1],[0 1],':k')
xlabel('p'); ylabel('u(p)')

figure(2)
hold on;
plot(0:0.001:1, Thalfperiod(0:0.001:1),'k')
xlabel('p'); ylabel('T_{period}(p)')


%% Step 2: Compute Koopman eigenfunction of ordinary pendulum
global Eigfuncphase eta

[ Eigfuncphase, eta] = eigenfunctionordinarypendulum_phase(  mu1, mu2, k,theta_kick );
theta0 = -theta_kick:(0.001*pi):theta_kick;
p0 = -1.4:.01:1.4;
[THETA0, P0] = meshgrid(theta0 , p0);

figure(15)
hold on
surf(THETA0, P0, Eigfuncphase(THETA0, P0) )
shading interp
axis([-pi/3 pi/3 -1.4 1.4 -pi pi])
xlabel('\theta'); ylabel('p');
view(0,90)
colorbar

%% Intermediate result: Eigenfunction squared on theta = - theta* and 0<p<1
p = 0:0.001:1;
Eigfuncphase_kicked = zeros(size(p));
for i = 1:length(p)  
    Eigfuncphase_kicked(i) = eigenfunctionkickedregion_phase( p(i), 0 );
      i
end
figure(2)
plot(p,Eigfuncphase_kicked,'k.','markersize', 5)
hold on
plot(-(1-p),Eigfuncphase_kicked,'k.','markersize', 5)
xlabel('p'); ylabel('|s_{\lambda}(-\theta^*,p)|')


%% Step 3: eigenfunction unkicked pendulum
global H
H = @(theta, p)(0.5*(mu1*mu2*p).^2 + 1 - cos(theta));

Hmin = H(theta_kick, 0);
Hplus = H(theta_kick, 1);

theta0 = -(pi/3):(0.001*pi):(pi/3);
p0 = -1.4:.01:1.4;
[THETA0, P0] = meshgrid(theta0 , p0);
s1phase = zeros(size(THETA0));

for ii = 1:size(THETA0,1);
   for jj = 1:size(THETA0,2);
      if H(THETA0(ii,jj),P0(ii,jj)) > Hplus
         s1phase(ii,jj) = NaN;
      else
         s1phase(ii,jj) = Eigfuncphase(THETA0(ii,jj),P0(ii,jj));
      end
   end
   display([num2str(ii), ' out of ', num2str(size(THETA0,1))])
end

figure(4)
hold on
surf(THETA0, P0, s1phase )
shading interp
axis([-pi/3 pi/3 -1.4 1.4 -pi pi])
caxis([-pi pi])
xlabel('\theta'); ylabel('p');
view(0,90)

%% Step 4: eigenfunction kicked pendulum
H = @(theta, p)(0.5*(mu1*mu2*p).^2 + 1 - cos(theta));

Hmin = H(theta_kick, 0);
Hplus = H(theta_kick, 1);

theta0 = -(pi/3):(0.001*pi):(pi/3);
p0 = -1.4:.01:1.4;
[THETA0, P0] = meshgrid(theta0 , p0);
s1phase = zeros(size(THETA0));

for ii = 1:size(THETA0,1);
   for jj = 1:size(THETA0,2);
       if H(THETA0(ii,jj),P0(ii,jj)) > Hplus
          s1phase(ii,jj) = NaN;
       elseif H(THETA0(ii,jj),P0(ii,jj)) <= Hmin
           s1phase(ii,jj) = Eigfuncphase(THETA0(ii,jj),P0(ii,jj));
       else   
          [Tinit, pinit, getskicked]  = simuntilfirstkick(THETA0(ii,jj),P0(ii,jj));
          if ~getskicked
             s1phase(ii,jj) = Eigfuncphase(THETA0(ii,jj),P0(ii,jj));
          else
             s1phase(ii,jj) = eigenfunctionkickedregion_phase( pinit, Tinit );
          end
       end
   end
  display([num2str(ii), ' out of ', num2str(size(THETA0,1))])
end

figure(4)
hold on
surf(THETA0, P0, s1phase )
shading interp
axis([-pi/3 pi/3 -1.4 1.4 -pi pi])
caxis([-pi pi])
xlabel('\theta'); ylabel('p');
view(0,90)



   
     
  