function [q] = nusseltTrend(t, par)
    par.battery.ncells = 60;
    nlayers = 2;
    omega = 80;
    Te = par.air.T;
    Ts = 315;
    
    % Battery configuration
    [nch, ~, ~] = batteryLayout(t, nlayers, par);
   
    % Fan flow
    [qfan,~] = fanFlow(omega, par);
    
    % Mass flow
    [u] = massFlow(qfan, nch, t, par);
    
    L = par.cell.l;
    
    [Dh, Ac, ~] = voidGeometry(t, par);
    
    %% Definition
    mdot = u*par.air.rho*Ac;
    G = mdot/Ac;
    Re = G*Dh/par.air.mu;

    Nub = 3.66 + 0.065*(Dh/L)*Re*par.air.Pr/(1 + 0.04*((Dh/L)*Re*par.air.Pr)^(2/3));
    
    % Exponents from Table 4.6 in Basic Heat and Mass Transfer
    Nu = variablePropertyCorrection(Nub, par.correction.lam.n, Te, Ts); 
    
    % Average heat transfer because of Nusselt number
    h_avg = (par.air.k/Dh)*Nu;
    
    % Bulk temperature at z = L
    Tb = Ts - (Ts - Te).*exp(-h_avg.*pi.*Dh.*L./mdot./par.air.cp);
    
    % Total powerflow from cells
    q = (Tb - Te)*par.air.cp*mdot;
end

