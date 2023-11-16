%% visualizing the basin of attraction for a typical limit cycle
clc,clear,clf

wn = 1;
kick_angle = 1;
w00 = 0.7;    % momentum of the limit cycle at the kick
theta0 = kick_angle;

% figure
PB = [0 .4470 .7410];
hold on 
box on
axis([-pi pi -4 4])
plot([-kick_angle -kick_angle],[0 -5],'--k')
plot([kick_angle kick_angle],[0 5],'--k')
plot([-pi pi],[0 0],'k')
xlabel('\theta'),ylabel('\omega/\Delta\omega')
title('RED: the limit cycle            BLUE: Basin of Attraction')

% upper part of basin of attraction
w0 = w00
[ theta2,omega2,~] = EllipticSolutions( wn,theta0,w0 );
t2 = theta2(omega2>0 & theta2<kick_angle); w2=omega2(omega2>0 & theta2<kick_angle);
[t2,ind]=sort(t2); w2=w2(ind);
plot(t2,w2,'Color',PB)
plot(theta2(omega2<0 & theta2<-kick_angle),omega2(omega2<0 & theta2<-kick_angle),'Color',PB)
plot(kick_angle,w0,'o','MarkerFaceColor',PB,'MarkerEdgeColor',PB,'MarkerSize',4)
plot(-kick_angle,-w0,'o','MarkerFaceColor','None','MarkerEdgeColor',PB,'MarkerSize',4)
w0 = w00+1
[ theta2,omega2,~] = EllipticSolutions( wn,theta0,w0 );
t2 = theta2(omega2<0 & theta2>-kick_angle); w2=omega2(omega2<0 & theta2>-kick_angle);
[t2,ind]=sort(t2); w2=w2(ind);
plot(t2,w2,'Color',PB)
plot(theta2(omega2>0 & theta2>kick_angle),omega2(omega2>0 & theta2>kick_angle),'Color',PB)
plot(-kick_angle,-w0,'o','MarkerFaceColor',PB,'MarkerEdgeColor',PB,'MarkerSize',4)
plot(kick_angle,w0,'o','MarkerFaceColor','None','MarkerEdgeColor',PB,'MarkerSize',4)

% rotary
[ theta3,omega3,~] = EllipticSolutions( wn,theta0,w00+2 );
theta3 = [fliplr(-theta3),theta3]; omega3 = [fliplr(omega3),omega3]; 
plot(theta3,omega3,'Color',PB)
[ theta3,omega3,~] = EllipticSolutions( wn,theta0,w00+3 );
theta3 = [fliplr(-theta3),theta3]; omega3 = [fliplr(omega3),omega3]; 
plot(theta3,omega3,'Color',PB)

% lower part of basin of attraction
w0 = w00-1
[ theta2,omega2,~] = EllipticSolutions( wn,theta0,w0 );
t2 = theta2(omega2<0 & theta2>-kick_angle); w2=omega2(omega2<0 & theta2>-kick_angle);
[t2,ind]=sort(t2); w2=w2(ind);
plot(t2,w2,'Color',PB)
plot(theta2(omega2>0 & theta2>kick_angle),omega2(omega2>0 & theta2>kick_angle),'Color',PB)
plot(-kick_angle,w0,'o','MarkerFaceColor',PB,'MarkerEdgeColor',PB,'MarkerSize',4)
plot(kick_angle,-w0,'o','MarkerFaceColor','None','MarkerEdgeColor',PB,'MarkerSize',4)
w0 = w00-2
[ theta2,omega2,~] = EllipticSolutions( wn,theta0,w0 );
t2 = theta2(omega2>0 & theta2<kick_angle); w2=omega2(omega2>0 & theta2<kick_angle);
[t2,ind]=sort(t2); w2=w2(ind);
plot(t2,w2,'Color',PB)
plot(theta2(omega2<0 & theta2<-kick_angle),omega2(omega2<0 & theta2<-kick_angle),'Color',PB)
plot(kick_angle,-w0,'o','MarkerFaceColor',PB,'MarkerEdgeColor',PB,'MarkerSize',4)
plot(-kick_angle,w0,'o','MarkerFaceColor','None','MarkerEdgeColor',PB,'MarkerSize',4)

% rotary
[ theta3,omega3,~] = EllipticSolutions( wn,theta0,w00-3 );
theta3 = [fliplr(-theta3),theta3]; omega3 = [fliplr(omega3),omega3]; 
plot(theta3,-omega3,'Color',PB)
[ theta3,omega3,~] = EllipticSolutions( wn,theta0,w00-4 );
theta3 = [fliplr(-theta3),theta3]; omega3 = [fliplr(omega3),omega3]; 
plot(theta3,-omega3,'Color',PB)

% the limit cycle
[ theta_u,omega_u,t ] = EllipticSolutions( wn,theta0,w00 );
omega_u(theta_u>kick_angle | theta_u<-kick_angle)=[];
theta_u(theta_u>kick_angle | theta_u<-kick_angle)=[];
theta_u(omega_u<0)=[];omega_u(omega_u<0)=[];
[theta_u,ind]=sort(theta_u); omega_u=omega_u(ind);
plot(theta_u,omega_u,'r')
[ theta_l,omega_l,t ] = EllipticSolutions( wn,theta0,w00-1 );
omega_l(theta_l>kick_angle | theta_l<-kick_angle)=[];
theta_l(theta_l>kick_angle | theta_l<-kick_angle)=[];
theta_l(omega_l>0)=[];omega_l(omega_l>0)=[];
[theta_l,ind]=sort(theta_l); omega_l=omega_l(ind);
plot(theta_l,omega_l,'r')

