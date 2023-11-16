%% VISCOUS DAMPING at different kick angles
clc; clear all; close all;

g = 10;
l = 10;
mu1 = 1;
mu2 = sqrt(g/l);
f = @(t,y,k)([ mu1*y(2) ;
              - (mu2^2/mu1) * sin(y(1)) - k*y(2) ]); % Case 1: viscous damping
Ham =@(theta, p)(0.5*(mu1*mu2*p).^2 + 1 - cos(theta)); % Invariant for hamiltonian system         
theta_kick = [pi/3]
p = 0:0.01:1;  

% 1
k = 0.02;
p_plus = zeros(size(p));          
for i = 1:length(p)
    [ p_plus(i)] = eulersolver(f, p(i), theta_kick,k, 0.001);
end  
H1 = Ham (theta_kick*ones(size(p)), p);
H_plus1 = Ham (theta_kick*ones(size(p_plus)), p_plus);

% 2
k = 0.04;         
p_plus = zeros(size(p));          
for i = 1:length(p)
    [ p_plus(i)] = eulersolver(f, p(i), theta_kick,k, 0.001);
end  
H2 = Ham (theta_kick*ones(size(p)), p);
H_plus2 = Ham (theta_kick*ones(size(p_plus)), p_plus);

% 3
k = 0.08;   
p_plus = zeros(size(p));          
for i = 1:length(p)
    [ p_plus(i)] = eulersolver(f, p(i), theta_kick,k, 0.001);
end  
H3 = Ham (theta_kick*ones(size(p)), p);
H_plus3 = Ham (theta_kick*ones(size(p_plus)), p_plus);

% 4
k = 0.16;     
p_plus = zeros(size(p));          
for i = 1:length(p)
    [ p_plus(i)] = eulersolver(f, p(i), theta_kick,k, 0.001);
end  
H4 = Ham (theta_kick*ones(size(p)), p);
H_plus4 = Ham (theta_kick*ones(size(p_plus)), p_plus);

figure(2)
hold on;
plot(H1(1:2:end), H_plus1(1:2:end),'k')
plot(H2(1:2:end), H_plus2(1:2:end),'k:')
plot(H3(1:2:end), H_plus3(1:2:end),'k--')
plot(H4(1:2:end), H_plus4(1:2:end),'k-.')
plot([0 2],[0 2],'color', [0.5 0.5 0.5],'Linewidth',0.05)
xlabel('H'); ylabel('d(H)')
legend('k = 0.02', 'k = 0.04', 'k = 0.08', 'k = 0.16','Orientation','horizontal')
axis([Ham(theta_kick, 0) Ham(theta_kick, 1) Ham(theta_kick, 0) Ham(theta_kick, 1)])



