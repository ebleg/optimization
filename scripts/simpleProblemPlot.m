clear all; close all; clc;

t = linspace(0, 10e-3, 10);
omega = linspace(0, 300, 300);
nlayers = 4;

run params
run defaultPlotSettings

par.accu.ncells = 60;

[trng, omegarng] = meshgrid(t, omega);
cost = nan(size(trng));

for i = 1:numel(trng)
    cost(i) = combinedModel(omegarng(i), trng(i), nlayers, par);
%     plotSensitivityAnalysis(fun,xopt);
end

mesh(trng, omegarng, cost)
xlabel('t [m]')
ylabel('omega [rad/s]')


% [cost] = combinedModel(omega, t, nlayers, par)