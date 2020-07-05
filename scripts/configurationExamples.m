run params
t = 2e-3;
par.accu.ncells = 420;
par.accu.AR = 0.2;
nlayers = 5;
omega = 80;

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

plotCellTemperatures(t, nlayers, Tcells, par)