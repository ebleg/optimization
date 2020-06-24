% Test Davidson-Fletcher-Powell (DFP) Quasi-Newtons method
clear all; close all; clc;

fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [2,3];
H0 = hessian(fun, x0);
xopt = dfp(fun, x0, H0);

% % Check
% options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton','HessUpdate','dfp');
% % options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton','HessUpdate','dfp','MaxFunctionEvaluations',10000,'MaxIterations',10000);
% [x,fval,exitflag,output] = fminunc(fun,x0,options) 