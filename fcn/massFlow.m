function [u] = massFlow(qfan, nch, t, par)

    %% Calculate the velocity of air through the channels 
    mdotfan = qfan*par.air.rho;                         % Mass flow fan
    mdot = mdotfan/nch;     % Mass flow through one channel [kg/s]
    [~, Ac, ~] = voidGeometry(t, par);
    u = mdot/(par.air.rho*Ac);                    % Velocity of air through channel [m/s]                       
    
end