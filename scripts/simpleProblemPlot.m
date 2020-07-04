clear all; close all; clc;

t = linspace(0, 20e-3, 40);
omega = linspace(20, 150, 10);
nlayers = 2;

run params
run defaultPlotSettings

par.accu.ncells = 60;

[trng, omegarng] = meshgrid(t, omega);
cost = nan(size(trng));

for i = 1:numel(trng)
    [cost(i), partial] = combinedModel(omegarng(i), trng(i), nlayers, par);
end

mesh(trng, omegarng, cost)


% ylabel('omega [rad/s]')

% x0 = [0.005 50];
% costhandle = @(x) combinedModel(x(2), x(1), nlayers, par);
% [xopt] = nms(@costhandle,x0);