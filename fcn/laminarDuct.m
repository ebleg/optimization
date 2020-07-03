function [q, Tb] = laminarDuct(t, Ts, Te, L, u, par)
    [Dh, Ac, ~] = voidGeometry(t, par);
    
    %% Definition
    mdot = u*par.air.rho*Ac;
    G = mdot/Ac;
    Re = G*Dh/par.air.mu;
    
    %% Approximations
    % Square duct approximation (from Table 4.5 in Basic Heat and Mass Transfer) 
%     Nub = 3.6; 
    Nub = 3.66 + 0.065*(Dh/L)*Re*par.air.Pr/(1 + 0.04*((Dh/L)*Re*par.air.Pr)^(2/3));
    fb = 57/Re;
    
    %% Variabel property correction
    % Exponents from Table 4.6 in Basic Heat and Mass Transfer
    Nu = variablePropertyCorrection(Nub, par.correction.lam.n, Te, Ts); 
    
    % Average heat transfer because of Nusselt number
    h_avg = (par.air.k/Dh)*Nu;
    
    % Bulk temperature at z = L
    Tb = Ts - (Ts - Te).*exp(-h_avg.*pi.*Dh.*L./mdot./par.air.cp);
    
    % Total powerflow from cells
    q = (Tb - Te)*par.air.cp*mdot;
    
end

