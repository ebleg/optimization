%% ENGINEERING OPTIMIZATION PROJECT

close all; clear; clc;

run params
run defaultPlotSettings

AR = 1;
nlayers = 5; 

t = 0.001;
u = 0.5;

[nch, stack, dim] = batteryLayout(t, nlayers, AR, par);


Tcells = ones(stack.x, stack.y, stack.z)*par.cell.T0;
plotBattery(t, nlayers, AR, par);

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

%%
plotCellTemperatures(t, nlayers, AR, Tcells, par);



