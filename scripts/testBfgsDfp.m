clear; close all; clc;

[X, Y] = meshgrid(-5:0.1:5, -5:0.1:5);
Z = nan(size(X));

for i = 1:numel(X)
    Z(i) = rosen([X(i), Y(i)]);
end

contour(X, Y, Z, linspace(0, 1000, 30)); hold on;

x0 = [-2.1 2.7];
Hessupdate = false;      % true = bfgs, false = dfp 
[xopt,count,plot] = bfgs(@rosen, x0, Hessupdate);

%% Check
fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

% Check bfgs
% options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton',...
%     'HessUpdate','bfgs','MaxFunctionEvaluations',10000,...
%     'MaxIterations',10000, 'OutputFcn', @outfun);
% [xopt,fval,exitflag,output] = fminunc(fun,x0,options);

% Check dfp
% options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton',...
%     'HessUpdate','dfp','MaxFunctionEvaluations',10000,...
%     'MaxIterations',10000, 'OutputFcn', @outfun);
% [xopt,fval,exitflag,output] = fminunc(fun,x0,options);

%%

plot = [x0' plot];
for i = 1:count 
% scatter(plot(1,i), plot(2,i), 'filled','r');
 line([plot(1,i) plot(1,i'+1)],[plot(2,i) plot(2,i+1)], 'Color', '#D95319', 'Linewidth', 2, 'Marker', '*', 'MarkerSize', 5, 'HandleVisibility','off')
end

scatter(xopt(1), xopt(2), 'filled','b');

function stop = outfun(x, optimValues, state)
    persistent x0
    if isempty(x0)
        x0 = [0.022  0.0035];
    end
    
    stop = false;
    line([x0(1) x(1)],[x0(2) x(2)], 'Color', '#D95319', 'Linewidth', 2, 'Marker', '*', 'MarkerSize', 5, 'HandleVisibility','off')
    x0 = x;
    drawnow
end 

function y = rosen(x)
    y = (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2 ;
end