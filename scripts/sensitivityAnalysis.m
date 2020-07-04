clear all; close all; clc;

%% General

run params
run defaultPlotSettings
par.accu.ncells = 60;

%% 1 - Influence omega & t on cost

t = linspace(0, 20e-3, 10);
omega = linspace(20, 150, 10);
nlayers = 3;                      

[trng, omegarng] = meshgrid(t, omega);
cost = nan(size(trng));

for i = 1:numel(trng)
    [cost(i), partial] = combinedModel(omegarng(i), trng(i), nlayers, par);
end

mesh(trng, omegarng, cost);
xlim([0 20e-3]);
ylim([20 150]);
xlabel('$t$ [m]'); ylabel('$\omega$ [rad/s]'); zlabel('Cost [-]');

%% 2 - Influence of nlayers, omega and t on cost

t = linspace(0, 20e-3, 10);
omega = linspace(20, 150, 10);
nlayers = [2 3 4 5];

[trng, omegarng] = meshgrid(t, omega);
cost = nan(size(trng));
figure; 

for j = 1:length(nlayers)
for i = 1:numel(trng)
    [cost(i), partial] = combinedModel(omegarng(i), trng(i), nlayers(j), par);
end

subplot(2,2,j)
mesh(trng, omegarng, cost);
xlim([0 20e-3]);
ylim([20 150]);
% zlim([1.04 1.15]);
xlabel('$t$ [m]'); ylabel('$\omega$ [rad/s]'); zlabel('Cost [-]');

if j == 1
title('$2$ layers');
elseif j == 2
title('$3$ layers');
elseif j == 3
title('$4$ layers');
else
title('$5$ layers');
end
end

%% 3 - Influence of omega on cost function (costant nlayers & t)
t = 0.008;
omega = linspace(20, 150, 100);
nlayers = 3;                       

cost = nan(size(omega));

for i = 1:length(omega)
    [cost(i)] = combinedModel(omega(i), t, nlayers, par);
end

figure(3);
plot(omega, cost);
xlim([20 150]);
xlabel('$\omega$ [rad/s]'); ylabel('Cost [-]');

%% 4 - Influence of t on cost function (costant nlayers & omega)
t = linspace(0, 20e-3, 100);
omega = 50;
nlayers = 3;                       

cost = nan(size(t));

for i = 1:length(t)
    [cost(i)] = combinedModel(omega, t(i), nlayers, par);
end

figure(4);
plot(t, cost);
xlim([0 20e-3]);
xlabel('$t$ [m]'); ylabel('Cost [-]');

%% 5 - Influence of nlayers on cost function (costant t & omega)
t = 0.008;
omega = 50;
nlayers = [2 3 4 5];

cost = nan(size(nlayers));

for i = 1:length(nlayers)
    [cost(i)] = combinedModel(omega, t, nlayers(i), par);
end

figure(5);
bar(nlayers, cost);
xlabel('$n_{layers}$ [-]'); ylabel('Cost [-]');

%% 6 - Central finite difference gradients of objective function for different perturbations
t = 0.008;
omega = 50;
nlayers = 3;                        

x0 = [t omega];
costhandle = @(x) combinedModel(x(2), x(1), nlayers, par);

[ht, homega, dfdt, dfdw] = sensitivityanalysis1(costhandle,x0);

figure(6);
subplot(211)
semilogx(ht,dfdt')
xlabel('$h_{t}$'), ylabel('$\frac{df}{dt}$')
subplot(212)
semilogx(homega,dfdw')
xlabel('$h_{\omega}$'), ylabel('$\frac{df}{d\omega}$')

%% Central finite difference gradients of objective function for constant perturbation hx = 1e-8 and different values for the design variables.
t0 = 0.008;
omega0 = 50;
nlayers = 3;                       
t = linspace(0, 20e-3, 100);
omega = linspace(20, 150, 100);
hx = 1e-8;

x0 = [t0 omega0];
costhandle = @(x) combinedModel(x(2), x(1), nlayers, par);

[sensx1, sensx2] = sensitivityanalysis2(t,omega,costhandle,x0,hx);

figure(7);
subplot(211)
plot(t,sensx1')
xlabel('t'), ylabel('$\frac{df}{dt}$'), title('Sensitivities objective function')
subplot(212)
plot(omega,sensx2')
xlim([20 150]);
xlabel('Omega'), ylabel('$\frac{df}{domega}$'), title('Sensitivities objective function')

%% Central finite difference second order derivatives for constant perturbation hx = 1e-8 and different values for the design variables.
%  Check for convexity

t0 = 0.008;
omega0 = 50;
nlayers = 3;                       
t = linspace(0, 20e-3, 10);
omega = linspace(20, 150, 10);
ht = 1e-8;
homega = 1e-8;

x0 = [t0 omega0];
costhandle = @(x) combinedModel(x(2), x(1), nlayers, par);

[dfdtdt, dfdtdw, dfdwdt, dfdwdw] = sensitivityanalysis4(t,omega,costhandle,x0,ht,homega);

%%
figure(8);
subplot(211)
plot(t,dfdtdt')
xlabel('t'), ylabel('$\frac{df}{dt}$'), title('Sensitivities objective function')
subplot(212)
plot(omega,sensx2')
xlim([20 150]);
xlabel('Omega'), ylabel('$\frac{df}{domega}$'), title('Sensitivities objective function')



