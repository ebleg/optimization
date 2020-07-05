function [total, partial] = combinedModel(omega, t, nlayers, par)
    
%     fprintf('omega %f\n', omega);
%     fprintf('t %f\n', t);
    global fcncounts;

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
    
    weights = [1 1 1 1 1];
    partial = [Pin, ...
               (Tmax - par.air.T)/(par.cell.Tmax - Tmax), ...
               boundaryFcn(dim.x, par.cost.xwidth, par.cost.r_boundary), ...
               boundaryFcn(dim.y, par.cost.ywidth, par.cost.r_boundary), ...
               boundaryFcn(-t, 0, 500)];
    
    fcncounts = fcncounts + 1;
    total = nansum(weights.*partial);

end

