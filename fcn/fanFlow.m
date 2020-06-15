function [u, mdot] = fanFlow(Pin, D, par)
    %% Calculate the flow accross the fan
    % Parameters
    Cp = 4*par.fan.a*((1-par.fan.a)^2);
    
    % Air flow and mass flow
    u = (4*Pin/(Cp*0.5*par.air.rho*D*D*pi))^(1/3);
    mdot = 0.25*D^2*pi*u*par.air.rho;
end

