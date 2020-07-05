%% ENGINEERING OPTIMIZATION PROJECT
clear all; clc;
% close all;

run params
run defaultPlotSettings

% if(isempty(gcp))
%     parpool(4)
% end

%% Main optimization
% Choose optimization method
% 1 = NMS, 2 = BFGS, 3 = DFP, 4 = fminunc, 5 = fminsearch
routine = 4;

x0 = [150, 5];

nlayers = 10;

% x = [omega, t]
obj = @(x) combinedModel(x(1), x(2)/1e4, nlayers, par);

% Check number of layers
isdivisor = mod(par.accu.ncells, nlayers) == 0;

global fcncounts
fcncounts = 0;

tic 

if ~isdivisor
   warning('Invalid number of layers');
else
    [~, stack, mindim] = batteryLayout(0, nlayers, par);
    dimCheck = (mindim.x <= par.cost.xwidth) && ...
        (mindim.y <= par.cost.ywidth) && ...
        (mindim.z <= par.cost.z);

    if ~dimCheck
        warning('Invalid number of layers');
    else
        nlayers
        switch routine
            case 1
                x = nms(obj, x0);
            case 2
                [xopt, iterations, ~, fval] = bfgs(obj, x0, true);
            case 3
                [x, count] = bfgs(obj, x0, false);
            case 4
                options = optimoptions(@fminunc,'Algorithm', 'quasi-newton', ...
                    'HessUpdate','bfgs','MaxFunctionEvaluations',10000, ...
                    'Display', 'iter');
                [xopt] = fminunc(obj, x0, options);
            otherwise
                error('Invalid routine');
        end
    end
end
fcncounts = 0;

toc

%%
% for i = 2:size(xtraj, 2)
%    hold on;
%    line([xtraj(1,i-1) xtraj(1,i)],[xtraj(2,i-1) xtraj(2,i)], 'Color', '#3498db', 'Linewidth', 2, ...
%        'Marker', '*', 'MarkerSize', 5, 'HandleVisibility','off')
% end

function stop = outfun(x, optimValues, state)
    persistent x0
    if isempty(x0)
        x0 = [150, 10e-3*1e4];
    end
    
    stop = false;
    line([x0(1) x(1)],[x0(2) x(2)], 'Color', '#D95319', 'Linewidth', 2, 'Marker', '*', 'MarkerSize', 5, 'HandleVisibility','off')
    x0 = x;
    drawnow
end 