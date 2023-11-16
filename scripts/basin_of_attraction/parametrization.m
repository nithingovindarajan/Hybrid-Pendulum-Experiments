%% visualizing the basin of attraction for a typical limit cycle
clear,clf,clc
wn = 1;
kick_angle = 1;
w00 = 0.7;    % momentum of the limit cycle at the kick
theta0 = kick_angle;

% figure
box on
hold on
axis([-pi pi -4 5])
xlabel('\theta'), ylabel('\omega/\Delta\omega')
plot([-kick_angle -kick_angle],[0 -5],'--k')
plot([kick_angle kick_angle],[0 5],'--k')
plot([-pi pi],[0 0],'k')

% the limit cycle
% upper branch
[ theta_u,omega_u,t_u,T1 ] = PendulumSolution( wn,theta0,w00,kick_angle );
lind = find(abs(theta_u)<kick_angle-.001 & omega_u>0);
omega_u = omega_u(lind); theta_u=theta_u(lind); t_u = t_u(lind);
T_u = max(t_u);
% lower branch
[ theta_l,omega_l,t_l,~ ] = PendulumSolution( wn,theta0,w00-1,kick_angle );
lind = find(abs(theta_l)<kick_angle-.001 & omega_l<0);
t_l = t_l(lind);
T_l = max(t_l)-min(t_l);
TT = T_l+T_u;   

% plot with the extra tail
[ theta_u,omega_u,t_u,~ ] = PendulumSolution( wn,theta0,w00,kick_angle );
[t_u,tind] = sort(t_u); omega_u = omega_u(tind); theta_u=theta_u(tind);
hind = 1:ceil(length(t_u)/2);   % first half of the periodic orbit
t_u=t_u(hind); omega_u=omega_u(hind); theta_u=theta_u(hind);
z=zeros(size(theta_u));
surface([theta_u;theta_u],[omega_u;omega_u],[z;z],[t_u;t_u]*2*pi/TT,...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);   
% plot with the extra tail
[ theta_l,omega_l,t_l,T2 ] = PendulumSolution( wn,theta0,w00-1,kick_angle );
[t_l,tind]=sort(t_l,'descend');omega_l=omega_l(tind); theta_l=theta_l(tind);
hind = 1:ceil(length(t_l)/2);
t_l=t_l(hind); omega_l = omega_l(hind); theta_l=theta_l(hind); 
t_l = mod(t_l-min(t_l)+T_u,TT);
z=zeros(size(theta_l));
surface([theta_l;theta_l],[omega_l;omega_l],[z;z],[t_l;t_l]*2*pi/TT,...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);

    
% top isochrones
for i = 1:4
    [ theta,omega,t,T ] = PendulumSolution( wn,theta0,w00+i,kick_angle );
    k = sqrt((.25/(wn^2))*(w00+i)^2 + sin(theta0/2)^2); % modulus (square of root of energy)
    if k<=1
        lind = find(theta>-kick_angle+.001 & omega<(w00+i));
        theta = theta(lind); omega=omega(lind); t=t(lind);
        [t,tind] = sort(t,'descend'); omega=omega(tind); theta=theta(tind);
        t = mod(t-T/2+T1/2,TT);
        Tb(i)=T/2 + T1/2;
    else
        t = mod(t+sum(Tb),TT);        
        Tb(i)=T;
    end
    % plot
    z=zeros(size(theta));
    surface([theta;theta],[omega;omega],[z;z],[t;t]*2*pi/TT,...
            'facecol','no',...
            'edgecol','interp',...
            'linew',2);
end
% lower isochrones
for i = 2:4
    [ theta,omega,t,T ] = PendulumSolution( wn,theta0,w00-i,kick_angle );
    k = sqrt((.25/(wn^2))*(w00-i)^2 + sin(theta0/2)^2); % modulus (square of root of energy)
    if k<=1
        lind = find(theta<kick_angle-.001 & omega>(w00-i));
        theta = theta(lind); omega=omega(lind); t=t(lind);
        [t,tind] = sort(t,'ascend'); omega=omega(tind); theta=theta(tind);
        t = mod(t+T2/2+T_u,TT);
        Tc(i)=T/2 + T2/2 + T_u;
    else
        omega=-omega;t=fliplr(t);
        t = mod(t+sum(Tc),TT);        
        Tc(i)=T;
    end
    % plot
    z=zeros(size(theta));
    surface([theta;theta],[omega;omega],[z;z],[t;t]*2*pi/TT,...
            'facecol','no',...
            'edgecol','interp',...
            'linew',2);
end
caxis([0 2*pi])
colorbar
title(['Isochrons for a limit cycle with T=',num2str(TT)])