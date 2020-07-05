%% ENGINEERING OPTIMIZATION PROJECT

close all; clear all; clc;

run params
run defaultPlotSettings

% if(isempty(gcp))
%     parpool(4)
% end

%% Main optimization
% Choose optimization method
% 1 = NMS, 2 = BFGS, 3 = DFP, 4 = fminunc, 5 = fminsearch
routine = 1;

x0 = [150, 10e-3*1e4];

for nlayers = 6:6
    
    % x = [omega, t]
    obj = @(x) combinedModel(x(1), x(2)/1e4, nlayers, par);

    % Check number of layers
    isdivisor = mod(par.accu.ncells, nlayers) == 0;
    [~, stack, mindim] = batteryLayout(0, nlayers, par);
    dimCheck = (mindim.x <= par.cost.xwidth) && ...
               (mindim.y <= par.cost.ywidth) && ...
               (mindim.z <= par.cost.z);
    t_max = min((par.cost.xwidth - mindim.x)/(stack.x - 1), ...
                (par.cost.ywidth - mindim.y)/(stack.y - 1));
    
    fprintf('Max t %f', t_max);
    
    if ~(isdivisor && dimCheck)
       warning('Invalid number of layers');
    else
        switch routine
            case 1
                x = nms(obj, x0);
            case 2
                x = bfgs(obj, x0, true);
            case 3
                x = bfgs(obj, x0, false);
            case 4
                x = fminunc(obj, x0);
            case 5
                x = fminsearch(obj, x0);
                x = [x(1) x(2)*1e-4];
            otherwise
                error('Invalid routine');
        end
    end
end