function [u] = massFlow(mdotfan, stack, t, par)

    %% Calculate the velocity of air through the channels 
    mdot = mdotfan/((stack.x-1)*(stack.y-1));     % Mass flow through one channel [kg/s]
    [Dh, Ac, P] = voidGeometry(t, par)
    u = mdot/(par.air.rho*Ac);                    % Velocity of air through channel [m/s]                       
    
end