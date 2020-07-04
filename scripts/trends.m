clear all; close all; clc;

t = linspace(0, 20e-3, 10);
nlayers = 6;
omega = 20;

run params
run defaultPlotSettings

par.accu.ncells = 420;

costrng = nan(size(t));
Tavg = nan(size(t));
Tmax = nan(size(t));
for i = 1:numel(t)
   [~, ~, Tavg(i), ~, Tmax(i)] =  combinedModel(omega, t(i), nlayers, par);
end

plot(t, Tavg - par.air.T); hold on;
plot(t, Tmax - par.air.T);
xlabel('$t$ [m]')
ylabel('$T_{avg}$ [m]')
title('$T_{avg}$ vs $T$')

figure
omega = linspace(10, 150, 100);
Pin = nan(size(omega));
for i = 1:numel(omega)
    [~, Pin(i)] = fanFlow(omega(i), par);
end
plot(omega, Pin)