% Test Nelder-Mead Simplex Optimization Algorithm
clear all; close all; clc;

%% Benchmark: minimize Rosenbrock's function using fminsearch
options = optimset('Display','iter','PlotFCns',@optimplotfval);
fun = @(x)100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [-1.2,1.1];
[x,fval, exitflag, output] = fminsearch(fun,x0,options)

%% minimize Rosenbrock's function using self implemented Nelder-Mead Simplex
% optimization algorithm

% 1: Inputs

% 2: Initial simplex
x0 = [-1.2,1.1];

% 3: Findings

% 4: Convergance Control

% 5: Renewal of the worst corner by adjusting the step scale

% 6: Shrinkage of the simplex




