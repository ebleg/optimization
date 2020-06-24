% Test Davidson-Fletcher-Powell (DFP) Quasi-Newtons method
clear all; close all; clc;

fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [2, 3];
H0 = hessian(f, x0);
xopt = dfp(f, x0, H0)