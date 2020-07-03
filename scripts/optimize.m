clear all; close all; clc;

t = linspace(0, 20e-3, 10);
omega = linspace(20, 150, 10);

run params
run defaultPlotSettings

par.accu.ncells = 60;
nlayers = 4;

[trng, omegarng] = meshgrid(t, omega);
cost = nan(size(trng));
    
for i = 1:numel(trng)
    [cost(i)] = combinedModel(omegarng(i), trng(i), nlayers, par);
end

mesh(trng, omegarng, cost); hold on;
xlabel('t [m]'); ylabel('omega [rad/s]')

% [costx0] = combinedModel(x0(2), x0(1), nlayers, par);
% plot3(x0(1),x0(2),costx0,'*','LineWidth',3);

%% Optimization

x0 = [0.010 100];
costhandle = @(x) combinedModel(x(2), x(1), nlayers, par);

% NMS
[xopt] = nms(costhandle,x0);

% NMS check
[x,fval] = fminsearch(costhandle,x0);

% % BFGS / DFP
% Hessupdate = true;      % true = bfgs, false = dfp 
% [xopt,count,plot] = bfgs(costhandle,x0, Hessupdate);

[cost123] = combinedModel(xopt(2), xopt(1), nlayers, par);
plot3(xopt(1),xopt(2),cost123,'*','LineWidth',3); hold on;
plot3(x(1),x(2),fval,'ro','LineWidth',3);


