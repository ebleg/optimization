function [cost, meta] = combinedModel(omega, t, nlayers, par)
    % Fan flow
    [mdot_fan, Pin] = fanFlow(omega, par);
    
    % Battery configuration
    [nch, stack, dim] = batteryLayout(t, nlayers, par);
    
    % Channel area
    [~, Ac, ~] = voidGeometry(t, par);
    
    % Mass flow distribution
    u = mdot_fan/nch/Ac;  % mass conservation + equal distribution over channels
    
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
    
    % TODOOOOOOOOOOOOOOOOOOOO
    cost = 0;

end

