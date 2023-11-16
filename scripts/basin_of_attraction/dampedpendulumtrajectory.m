%% visualizing the basin of attraction for a typical limit cycle
clc,clear,clf

kick_angle = pi/3;
kick_strength = 1;
wn = 1;

omega_crit = sqrt(2+2*cos(kick_angle))*wn;
p1 = 0.7;



w00 = p1*wn;    % momentum of the limit cycle at the kick
theta0 = kick_angle;

%k = sqrt((.25/(wn^2))*w00^2 + sin(theta0/2)^2); % modulus

% cmp = colormap(parula(128));

% state space and kick surfaces
% figure
PB = [0 .4470 .7410];
hold on 
box on
axis([-pi pi -4 4])
plot([-kick_angle -kick_angle],[0 -5],'--k')
plot([kick_angle kick_angle],[0 5],'--k')
plot([-pi pi],[0 0],'k')
xlabel('\theta'),ylabel('p')


% Draw homoclinic orbit part
w0 =omega_crit;
[ theta2,omega2,~] = EllipticSolutions( wn,theta0,w0 );
plot(theta2,omega2,'k:')
w0 = omega_crit;
[ theta2,omega2,~] = EllipticSolutions( wn,-theta0,w0 );
plot(theta2,omega2,'k:')


k = sqrt((  .25/(wn^2))*w0^2 + sin(theta0/2)^2);



[ theta,omega,t ] = EllipticSolutions( 1, -pi/3, 1 );
omega(theta>=pi/3) = NaN; 
omega(theta<=-pi/3) = NaN;
[ theta2,omega2,t ] = EllipticSolutions( 1, -pi/3, 0 );
%plot(theta,omega,'k','LineWidth',1.5)
plot(theta2,omega2,'k','LineWidth',1.5)
text(-0.8,-0.25,'unperturbed region','Fontsize',12)
text(1,-2.5,'kicked region','Fontsize',12)



[ theta,omega,t ] = EllipticSolutions( 1, -pi/3, 1 );
omega(theta>=pi/3) = NaN; 
omega(theta<=-pi/3) = NaN;
[ theta2,omega2,t ] = EllipticSolutions( 1, -pi/3, 0 );
plot([-kick_angle, -kick_angle], [-1, 1], 'k:','LineWidth',1.5)
plot([kick_angle, kick_angle], [-1, 1], 'k:','LineWidth',1.5)
plot(theta,omega,'k:','LineWidth',1.5)
plot(theta2,omega2,'k:','LineWidth',1.5)
text(-0.4,-1.2,'attracting set')


%% Simulate typical trajectory


g = 10;
l = 10;


mu1 = 1;
mu2 = sqrt(g/l);

% Case 1: viscous damping
f = @(y,k)([ mu1*y(2) ;
              - (mu2^2/mu1) * sin(y(1)) - k*y(2) ]);
          
k = 0.06;



h = 0.01;
time = 0:h:50;


y = [2.5; -.9];


plot(y(1),y(2),'b.','MarkerSize',15)

y_store = zeros(2,length(time));

for s = 1:9
   s 
   y
    for l=1:length(time)
        
        % integrate
        y_old = y;
        y_store(:,l) = y;
        y = y + h*f(y,k); 
        % correction
        y = mod(y+pi,2*pi)-pi;

        % guard condition
        if y_old(1) > -kick_angle &  y(1) < -kick_angle
            type = 1; 
            break;
        elseif y_old(1) < kick_angle &  y(1) > kick_angle
            type = 2; 
            break;
        end
        
     
    end
    

    % reset
    if type == 1

        y(1) = -kick_angle;  
        y(2) = y(2)+1;
        
    elseif type == 2

        y(1) = kick_angle;
        y(2) = y(2)-1;
        
    end
  

    plot(y_store(1,1:l),y_store(2,1:l),'b')
    
    
end

