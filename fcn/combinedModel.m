function [cost] = combinedModel(omega, t, nlayers, par)
% [total, cost, meta] = combinedModel(omega, t, nlayers, par)

%     t = max(0, t);
%     omega = max(0, omega);

    % Battery configuration
    [nch, stack, dim] = batteryLayout(t, nlayers, par);
   
    % Fan flow
    [qfan,Pin] = fanFlow(omega, par);
    
    % Mass flow
    [u] = massFlow(qfan, stack, t, par);
    
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
        Tmax = max(Tcells(:));
        Tavg = mean(Tcells(:));

        i = i + 1;
    end
    
%   Tmax = smoothmax(Tcells(:), 1);
%     Tmax = max(Tcells(:));
%     Tavg = mean(Tcells(:));
    
    % Cost function
    option = 8;
    
    if option == 1
    cost  = [boundaryFcn(dim.x, 0, par.cost.xwidth, par.cost.r_boundary), ...
             boundaryFcn(dim.y, 0, par.cost.ywidth, par.cost.r_boundary), ...
             boundaryFcn(dim.z, 0, par.cost.z, par.cost.r_boundary), ...
             boundaryFcn(Tmax, 0, par.cell.Tmax, par.cost.r_boundary), ...
             Tavg/300, ...
             -20*Pin/par.cost.P_nominal];
    elseif option == 2
    cost  = [boundaryFcn(dim.x, 0, par.cost.xwidth, par.cost.r_boundary), ...
             boundaryFcn(dim.y, 0, par.cost.ywidth, par.cost.r_boundary), ...
             boundaryFcn(dim.z, 0, par.cost.z, par.cost.r_boundary), ...
             boundaryFcn(Tmax, 0, par.cell.Tmax, par.cost.r_boundary), ...
             Tavg/300, ...
             10*Pin/par.cost.P_nominal];
    elseif option == 3
    cost1 = boundaryFcn(dim.x, 0, par.cost.xwidth, par.cost.r_boundary) + boundaryFcn(dim.y, 0, par.cost.ywidth, par.cost.r_boundary) + boundaryFcn(dim.z, 0, par.cost.z, par.cost.r_boundary) + boundaryFcn(Tmax, 0, par.cell.Tmax, par.cost.r_boundary);
    cost2 = 100*(Tavg - par.air.T)/(par.cell.Tmax - par.air.T) + 0*Pin/2/par.cost.P_max;
    cost = cost1 + cost2;
    elseif option == 4
    cost1 = boundaryFcn(dim.x, 0, par.cost.xwidth, par.cost.r_boundary) + boundaryFcn(dim.y, 0, par.cost.ywidth, par.cost.r_boundary) + boundaryFcn(dim.z, 0, par.cost.z, par.cost.r_boundary) + boundaryFcn(Tmax, 0, par.cell.Tmax, par.cost.r_boundary);
    cost2 = Tavg/300 -20*Pin/par.cost.P_nominal;
    cost = cost1 + cost2; 
    elseif option == 5
    cost1 = boundaryFcn(dim.x, 0, par.cost.xwidth, par.cost.r_boundary) + boundaryFcn(dim.y, 0, par.cost.ywidth, par.cost.r_boundary) + boundaryFcn(dim.z, 0, par.cost.z, par.cost.r_boundary) + boundaryFcn(Tmax, 0, par.cell.Tmax, par.cost.r_boundary);
    cost2 = (Tavg-par.air.T)/(par.cell.Tmax-par.air.T) + (Pin/par.cost.P_max);
    cost = cost1 + cost2; 
    elseif option == 6
    cost1 = boundaryFcn(dim.x, 0, par.cost.xwidth, par.cost.r_boundary) + boundaryFcn(dim.y, 0, par.cost.ywidth, par.cost.r_boundary) + boundaryFcn(dim.z, 0, par.cost.z, par.cost.r_boundary);
    cost2 = (Tavg-par.air.T)/(par.cell.Tmax-par.air.T) + (Pin/par.cost.P_max);
    cost = cost1 + cost2; 
    elseif option == 7
    cost = (Tavg-par.air.T)/(par.cell.Tmax-par.air.T) + (Pin/par.cost.P_max);
    elseif option == 8
    cost = (Tavg-par.air.T)/(par.cell.Tmax-par.air.T);
    else 
    cost = Pin/par.cost.P_max;
    
%     total = sum(cost);
%     meta.Tcells = Tcells;


end

