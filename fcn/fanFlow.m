function [mdotfan,Pin] = fanFlow(omega, par)
    
    % Calculate the flow accross the fan
    ufan = par.fan.u1*(omega/par.fan.omega1);           % Volumetric flow fan
    mdotfan = ufan*par.air.rho;                         % Mass flow fan
    
    %Calculate input power
    Pin = par.fan.p1*((omega/par.fan.omega1)^3);        % Power input fan [W]
    
<<<<<<< HEAD
end

=======
    % Air flow and mass flow
    u = (4*Pin/(Cp*0.5*par.air.rho*D*D*pi))^(1/3);
    mdot = 0.25*D^2*pi*u*par.air.rho;
end
>>>>>>> 5d9adfe8b8cb59feb34eec6f957b6111d30c3385
