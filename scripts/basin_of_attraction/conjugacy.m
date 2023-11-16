%% visualizing the basin of attraction for a typical limit cycle
clc,clear,clf

kick_angle = pi/3;
kick_strength = 1;
wn = 1;
omega_crit = sqrt(2+2*cos(kick_angle))*wn
p1 = 0.7;

figure(1)
subplot(1,2,1)
w00 = p1*wn;    % momentum of the limit cycle at the kick
theta0 = kick_angle;
PB = [0 .4470 .7410];
hold on 
box on
axis square;

% the limit cycle
[theta_u,omega_u,t] = EllipticSolutions(wn,theta0,w00);
omega_u(theta_u>kick_angle | theta_u<-kick_angle)=[];
theta_u(theta_u>kick_angle | theta_u<-kick_angle)=[];
theta_u(omega_u<0)=[];omega_u(omega_u<0)=[];
[theta_u,ind]=sort(theta_u); omega_u=omega_u(ind);
plot(theta_u,omega_u,'r')
[theta_l,omega_l,t] = EllipticSolutions(wn,theta0,w00-1);
omega_l(theta_l>kick_angle | theta_l<-kick_angle)=[];
theta_l(theta_l>kick_angle | theta_l<-kick_angle)=[];
theta_l(omega_l>0)=[];omega_l(omega_l>0)=[];
[theta_l,ind]=sort(theta_l); omega_l=omega_l(ind);
plot(theta_l,omega_l,'r')
[ theta,omega,t ] = EllipticSolutions( 1, -pi/3, 1 );
omega(theta>=pi/3) = NaN; 
omega(theta<=-pi/3) = NaN;
[ theta2,omega2,t ] = EllipticSolutions( 1, -pi/3, 0 );
plot([-kick_angle, -kick_angle], [-1, 1], 'k','LineWidth',1.5)
plot([kick_angle, kick_angle], [-1, 1], 'k','LineWidth',1.5)
plot(theta,omega,'k','LineWidth',1.5)
plot(theta2,omega2,'k','LineWidth',1.5)
title('Flow on the attracting set')
grid off
axis off

%%
figure(1)
subplot(1,2,2)
hold all
% Plot upper surface
center = [0,0,0.3];
radius = 0.5;
NOP = 1000;
THETA=linspace(0,2*pi,NOP);
RHO=ones(1,NOP)*radius;
[X,Y] = pol2cart(THETA,RHO);
X=X+center(1);
Y=Y+center(2);
Z = center(3)*ones(1,length(X));
trajectory = plot3(X,Y,Z,'r')
% Plot cylinder
[X,Y,Z] = cylinder(0.5,100);
[TRI,v]= surf2patch(X,Y,Z); 
hSurface = patch('Vertices',v,'Faces',TRI,'facecolor',[0.1 0.1 0.1],'facealpha',0.1);
set(hSurface,'edgecolor','none')
axis square;  
grid off
hold off
axis off
rotate(hSurface,[1 0 0],90)
rotate(trajectory,[1 0 0],90)
view(3);
title('Shear flow on the cylinder')


