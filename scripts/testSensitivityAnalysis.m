clear all; close all; clc;

fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
xopt = [1,1];

plotSensitivityAnalysis(fun,xopt);