% Test Davidson-Fletcher-Powell (DFP) Quasi-Newtons method
clear all; close all; clc;

% figure; hold on;
% axis equal;
% 
fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
% 
% [X, Y] = meshgrid(-3:0.1:3, -3:0.1:3);
% Z = nan(size(X));
% 
% for i = 1:numel(X)
%     Z(i) = fun([X(i), Y(i)]);
% end
% 
% contour(X, Y, Z, linspace(0, 1000, 30));
% grid; grid minor;

x0 = [1.5,1.5];
H0 = hessian(fun, x0);
xopt = dfp(fun, x0, H0);

% % Check
% options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton','HessUpdate','dfp');
% % options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton','HessUpdate','dfp','MaxFunctionEvaluations',10000,'MaxIterations',10000);
% [xopt,fval,exitflag,output] = fminunc(fun,x0,options) 

% scatter(xopt(1), xopt(2), 'filled');
% 
% hold on;