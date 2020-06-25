clear all; close all; clc;

fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [-2.9723 0.1679];

%% Genetic algorithms
% Measure time
tic;
[xopt, scores] = ga(fun,length(x0))
toc;
 
% % Visualize
% options = optimoptions('ga','PlotFcn',{@gaplotbestf,@gaplotbestindiv,@gaplotexpectation,@gaplotstopping});
% [xopt, scores, exitflag, output] = ga(fun,length(x0),options)
