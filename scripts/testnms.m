% Test Nelder-Mead Simplex Optimization Algorithm
clear all; close all; clc;

% Rosenbrock's function
fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [3 4];

%% Benchmark: minimize Rosenbrock's function using fminsearch
% fminsearch uses the Nelder-Mead Simplex algorithm
% 
% options = optimset('Display','iter','PlotFCns',@optimplotfval);
% [x,fval, exitflag, output] = fminsearch(fun,x0,options);

%% Self implemented Nelder-Mead Simplex optimization algorithm
% Used to minimize Rosenbrock's function

% References:
% https://github.com/t-k-/nelder-mead-simplex/blob/master/nelder_mead_simplex.m

% % Check: Visualization
% 	[X,Y] = meshgrid(-2.2:0.2:2.2, -2.8:0.2:6);
% 	Z = zeros(size(X));
% 	for i = 1:numel(X)
% 		Z(i) = fun([X(i) Y(i)]');
% 	end
% 	hold on; grid on;
% 	mesh(X, Y, Z)
% 	alpha(0.3)
% 	contour(X, Y, Z)
% 	color = [1 0 0]';

[xopt] = nms(fun,x0);







