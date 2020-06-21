function [mdotfan,Pin] = fanFlow(omega, par)
    
    % Calculate the flow accross the fan
    ufan = par.fan.u1*(omega/par.fan.omega1);           % Volumetric flow fan
    mdotfan = ufan*par.air.rho;                         % Mass flow fan
    
    %Calculate input power
    Pin = par.fan.p1*((omega/par.fan.omega1)^3);        % Power input fan [W]
    
end
