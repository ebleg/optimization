function [Dh, Ac, P] = voidGeometry(t, par)

    Ac = (4 - pi).*par.cell.r.^2 ...
          + t.^2 ...
          + 4.*par.cell.r.*t;
             
    P = 4.*t + 2*par.cell.r.*pi;

    Dh = 4*Ac./P;

end

