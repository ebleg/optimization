clear all; close all; clc;

t = linspace(0, 20e-3, 10);
omega = linspace(20, 150, 10);
nlayers = 4;

run params
run defaultPlotSettings

par.accu.ncells = 60;

[trng, omegarng] = meshgrid(t, omega);
cost = nan(size(trng));

for i = 1:numel(trng)
    [cost(i), partial] = combinedModel(omegarng(i), trng(i), nlayers, par);
%     plotSensitivityAnalysis(fun,xopt);
    bar(partial)
end

mesh(trng, omegarng, cost)
xlabel('t [m]')
ylabel('omega [rad/s]')

[cost] = combinedModel(omega, t, nlayers, par)
x0 = [0.012 120];
[xopt] = nms(cost,x0);