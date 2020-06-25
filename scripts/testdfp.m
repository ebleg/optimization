% Test Davidson-Fletcher-Powell (DFP) Quasi-Newtons method
clear all; close all; clc;

% Possible test functions
f = @(x) (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2 ;
% f = @(x) (x(1)).^2 + (x(2)).^2 ;
% f = @(x) (x(1)^2 + x(2) - 11)^2 + (x(1) + x(2)^2 - 7)^2;
x0 = [-2.1 2.7];

% Plot contours
figure; hold on;
axis equal;
[X, Y] = meshgrid(-5:0.1:5, -5:0.1:5);
Z = nan(size(X));
for i = 1:numel(X)
    Z(i) = f([X(i), Y(i)]);
end
contour(X, Y, Z, linspace(0, 1000, 30));
grid; grid minor;

% Optimize
xopt = dfp(f, x0, eye(2));

% % Check
% options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton',...
%     'HessUpdate','dfp','MaxFunctionEvaluations',10000,...
%     'MaxIterations',10000, 'OutputFcn', @outfun);
% 
% [xopt,fval,exitflag,output] = fminunc(f,x0,options);

% Plot optimalisation
scatter(xopt(1), xopt(2), 'filled');
function stop = outfun(x, optimValues, state)
    persistent x0
    if isempty(x0)
        x0 = [-2.1 2.7];
    end
    
    stop = false;
    line([x0(1) x(1)],[x0(2) x(2)], 'Color', '#D95319', 'Linewidth', 2, 'Marker', '*', 'MarkerSize', 5, 'HandleVisibility','off')
    x0 = x;
    drawnow
end 