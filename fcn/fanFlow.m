function [qfan,Pin] = fanFlow(omega, par)
    
    % Calculate the flow accross the fan
    qfan = par.fan.q1*(omega/par.fan.omega1);           % Volumetric flow fan
    
    %Calculate input power
    Pin = par.fan.p1*((omega/par.fan.omega1)^3);        % Power input fan [W]
    
end
