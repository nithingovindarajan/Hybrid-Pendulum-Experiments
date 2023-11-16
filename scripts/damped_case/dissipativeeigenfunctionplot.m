clc;
clear all;
close all;

load s1mod.mat

figure(1)
hold on
surf(THETA0, P0, s1mod )
shading interp
axis([-pi/3 pi/3 -1.4 1.4 0 10])
caxis([0 1.8])
xlabel('\theta'); ylabel('p');
view(0,90)
colorbar

%%
clc;
clear all;
close all;

load s1modunkicked.mat

figure(1)
hold on
surf(THETA0, P0, s1mod )
shading interp
axis([-pi/3 pi/3 -1.4 1.4 0 10])
caxis([0 1.8])
xlabel('\theta'); ylabel('p');
view(0,90)
colorbar

%%
clc;
clear all;
close all;

load s1phase.mat

figure(3)
hold on
surf(THETA0, P0, s1phase )
shading interp
axis([-pi/3 pi/3 -1.4 1.4 -pi pi])
caxis([-pi pi])
xlabel('\theta'); ylabel('p');
view(0,90)
colorbar

%%
clc;
clear all;
close all;

load s1phaseunkicked.mat

figure(3)
hold on
surf(THETA0, P0, s1phase )
shading interp
axis([-pi/3 pi/3 -1.4 1.4 -pi pi])
caxis([-pi pi])
xlabel('\theta'); ylabel('p');
view(0,90)
colorbar

%%
clc;
clear all;
close all;

load s1modkicksurf.mat
load s1phasekicksurf.mat

figure(2)
plot(p,Eigfuncnorm_kicked,'k.','markersize', 5)
hold on
axis([-1, 1, 0.65 2])
plot(-(1-p),Eigfuncnorm_kicked,'k.','markersize', 5)
xlabel('$p$','Interpreter','latex','FontSize', 15); ylabel('$|\phi_{\lambda}(-\theta^*,p)|$','Interpreter','latex','FontSize', 15)

figure(3)
plot(p,Eigfuncphase_kicked,'k.','markersize', 5)
hold on
plot(-(1-p),Eigfuncphase_kicked,'k.','markersize', 5)
xlabel('$p$','Interpreter','latex','FontSize', 15); ylabel('$\angle \phi_{\lambda}(-\theta^*,p)$','Interpreter','latex','FontSize', 15)

