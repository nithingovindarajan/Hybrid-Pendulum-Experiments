%% visualizing the basin of attraction for a typical limit cycle
clc,clear,clf

kick_angle = pi/3;
kick_strength = 1;
wn = 1;
omega_crit = sqrt(2+2*cos(kick_angle))*wn
p1 = 0.7;
w00 = p1*wn;    % momentum of the limit cycle at the kick
theta0 = kick_angle;

% figure
PB = [0 .4470 .7410];
hold on 
box on
axis([-pi pi -4 4])
plot([-kick_angle -kick_angle],[0 -5],'--k')
plot([kick_angle kick_angle],[0 5],'--k')
plot([-pi pi],[0 0],'k')
xlabel('\theta'),ylabel('p')

% Draw homoclinic orbit
w0 =omega_crit;
[ theta2,omega2,~] = EllipticSolutions( wn,theta0,w0 );
plot(theta2,omega2,'k:')
w0 = omega_crit;
[ theta2,omega2,~] = EllipticSolutions( wn,-theta0,w0 );
plot(theta2,omega2,'k:')
k = sqrt((  .25/(wn^2))*w0^2 + sin(theta0/2)^2)
[ theta,omega,t ] = EllipticSolutions( 1, -pi/3, 1 );
omega(theta>=pi/3) = NaN; 
omega(theta<=-pi/3) = NaN;
[ theta2,omega2,t ] = EllipticSolutions( 1, -pi/3, 0 )
plot(theta2,omega2,'k','LineWidth',1.5)
text(-0.8,-0.25,'unperturbed region','Fontsize',12)
text(1,-2.5,'kicked region','Fontsize',12)
