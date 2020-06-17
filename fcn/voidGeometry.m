function [Dh, Ac, P] = voidGeometry(t, par)
    % Cross-sectional diameter
    Ac = (4 - pi).*par.cell.r.^2 ...
          + t.^2 ...
          + 4.*par.cell.r.*t;
    
    % Wetted perimeter
    P = 2*par.cell.r.*pi; % Don't include the edges that don't touch the cells

    % Hydraulic diameter
    Dh = 4*Ac./P;

end

