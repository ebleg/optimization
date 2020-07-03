function [total, cost] = combinedModel(omega, t, nlayers, par)

%     t = max(0, t);
%     omega = max(0, omega);

    % Battery configuration
    [nch, stack, dim] = batteryLayout(t, nlayers, par);
   
    % Fan flow
    [qfan,Pin] = fanFlow(omega, par);
    
    % Mass flow
    [u] = massFlow(qfan, nch, t, par);
    
    % Thermal model
    Tcells = ones(stack.x, stack.y, stack.z)*par.cell.T0;

    channels = struct();
    channels.T = ones(stack.x-1, stack.y-1, stack.z)*par.air.T;  % outlet temperature
    channels.q = ones(stack.x-1, stack.y-1, stack.z);

    i = 0; converged = false;

    while ~converged && (i <= 1000)
        channels = updateChannelTemp(t, u, channels, Tcells, par);
        TcellsNew = updateCellTemp(Tcells, channels, stack, par);

        if mean(abs(TcellsNew - Tcells)) < 1e-2
            converged = true;
        end

        Tcells = TcellsNew;


        i = i + 1;
    end
    
    Tmax = smoothmax(Tcells(:), 1);
    Tavg = mean(Tcells(:));
    
    normalize = @(x) x/norm(x);
    weights = normalize([1 1 1 1 20 1]);
    
    cost = normalize(weights.*[boundaryFcn(dim.x, 0, par.cost.xwidth, par.cost.r_boundary), ...
                     boundaryFcn(dim.y, 0, par.cost.ywidth, par.cost.r_boundary), ...
                     boundaryFcn(dim.z, 0, par.cost.z, par.cost.r_boundary), ...
                     boundaryFcn(Tmax, 0, par.cell.Tmax, par.cost.r_boundary), ...
                     Tavg/300, ...
                     Pin/par.cost.P_nominal]);
    total = sum(cost);

end

