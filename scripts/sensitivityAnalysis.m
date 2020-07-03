clear all; close all; clc;

%% General

t = linspace(0, 20e-3, 10);
omega = linspace(20, 150, 10);
run params
run defaultPlotSettings
par.accu.ncells = 60;

%% Influence omega & t on cost
% nlayers = 4;            % Random choice
% 
% [trng, omegarng] = meshgrid(t, omega);
% cost = nan(size(trng));
% 
% for i = 1:numel(trng)
%     [cost(i), partial] = combinedModel(omegarng(i), trng(i), nlayers, par);
% end
% 
% mesh(trng, omegarng, cost);
% xlim([0 20e-3]);
% ylim([20 150]);
% xlabel('t [m]'); ylabel('omega [rad/s]')

%% Influence of nlayers, omega and t on cost
% nlayers = [2 3 4 5];
% [trng, omegarng] = meshgrid(t, omega);
% cost = nan(size(trng));
% figure; 
% 
% for j = 1:length(nlayers)
% for i = 1:numel(trng)
%     [cost(i), partial] = combinedModel(omegarng(i), trng(i), nlayers(j), par);
% end
% 
% subplot(2,2,j)
% mesh(trng, omegarng, cost);
% xlim([0 20e-3]);
% ylim([20 150]);
% % zlim([1.04 1.15]);
% xlabel('t [m]'); ylabel('omega [rad/s]')
% end

%% Influence of omega on cost function (costant nlayers & t)
% nlayers = 4;
% t = 0.005;
% omega = linspace(20, 150, 100);
% 
% cost = nan(size(omega));
% 
% for i = 1:length(omega)
%     [cost(i)] = combinedModel(omega(i), t, nlayers, par);
% end
% 
% figure(3);
% plot(omega, cost);
% xlim([20 150]);
% xlabel('omega [rad/s]'); ylabel('cost');

%% Influence of t on cost function (costant nlayers & omega)
% nlayers = 4;
% omega = 50;
% t = linspace(0, 20e-3, 100);
% 
% cost = nan(size(t));
% 
% for i = 1:length(t)
%     [cost(i)] = combinedModel(omega, t(i), nlayers, par);
% end
% 
% figure(4);
% plot(t, cost);
% xlim([0 20e-3]);
% xlabel('t [rad/s]'); ylabel('cost');

%% Influence of nlayers on cost function (costant t & omega)
% nlayers = [2 3 4 5];
% omega = 50;
% t = 0.005;
% 
% cost = nan(size(nlayers));
% 
% for i = 1:length(nlayers)
%     [cost(i)] = combinedModel(omega, t, nlayers(i), par);
% end
% 
% figure(5);
% bar(nlayers, cost);
% xlabel('nlayers'); ylabel('cost');

%% Central finite difference gradients of objective function for different perturbations
% x0 = [0.005 50];
% nlayers = 3;
% costhandle = @(x) combinedModel(x(2), x(1), nlayers, par);
% 
% [hx, dfdx1, dfdx2] = sensitivityanalysis1(costhandle,x0);
% figure(6);
% subplot(211)
% semilogx(hx,dfdx1')
% xlabel('Difference step $hx$'), ylabel('$\frac{df}{dx_{1}}$'), title('Sensitivities objective function')
% subplot(212)
% semilogx(hx,dfdx2')
% xlabel('Difference step $hx$'), ylabel('$\frac{df}{dx_{2}}$'), title('Sensitivities objective function')

%% Central finite difference gradients of objective function for constant perturbation hx = 1e-8 and different values for the design variables.
x0 = [0.005 50];
nlayers = 3;
costhandle = @(x) combinedModel(x(2), x(1), nlayers, par);

[sensx1, sensx2] = sensitivityanalysis2(t,omega,costhandle,x0);
figure(7);
subplot(211)
plot(t,sensx1')
xlabel('t'), ylabel('$\frac{df}{dt}$'), title('Sensitivities objective function')
subplot(212)
plot(omega,sensx2')
xlabel('Omega'), ylabel('$\frac{df}{$d \omega$'), title('Sensitivities objective function')






