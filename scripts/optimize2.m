clear all; close all; clc;

run params
run defaultPlotSettings

par.accu.ncells = 60;
nlayers = 3;

%% Optimization

x0 = [100 0.010];
costhandle = @(x) combinedModel(x(1), x(2), nlayers, par);

% NMS
[xopt] = nms(costhandle,x0);

%%

% NMS check
options = optimset('PlotFcns',@optimplotfval);
[x,fval,exitflag,output] = fminsearch(costhandle,x0,options);





