clear; close all;

f = @(x) (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2 ;

[X, Y] = meshgrid(-5:0.1:5, -5:0.1:5);
Z = nan(size(X));

% for i = 1:numel(X)
%     Z(i) = f([X(i), Y(i)]);
% end

% contour(X, Y, Z, linspace(0, 1000, 30));

x0 = [-2.1 2.7];
xopt = bfgs(f, x0);

% scatter(xopt(1), xopt(2), 'filled');

% options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton',...
%     'HessUpdate','bfgs','MaxFunctionEvaluations',10000,...
%     'MaxIterations',10000, 'OutputFcn', @outfun);
% 
% [x,fval,exitflag,output] = fminunc(f,x0,options);

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