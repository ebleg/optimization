function [astar, phi_astar] = lineSearch2(fnc, amax, oldphi)
    a0 = 0; 
    meta = struct();
    meta.phi = fnc;
    meta.phi_deriv = @(a) findif(meta.phi, a);
    meta.C1 = 1e-4;
    meta.C2 = 0.9;
    meta.phi_at0 = meta.phi(0);
    meta.dphi_at0 = meta.phi_deriv(0);
    
    phi0 = meta.phi_at0;
    dphi0 = meta.dphi_at0;      
    
    a1 = 1;
    
    dphi1 = meta.phi_deriv(a1);
    phi1 = meta.phi(a1);

    max_iter = 10;
    
    for i = 1:max_iter
        % First condition
        if (phi1 > (meta.phi_at0 + meta.C1*a1*meta.dphi_at0)) || ...
                ((phi1 >= phi0) && i > 1)
            [astar, phi_astar] = zoom(meta, a0, phi0, dphi0, a1, phi1, dphi1); break;
        end
        
        % Second condition
        if (abs(dphi1) <= -meta.C2*meta.dphi_at0)
           astar = a1; 
           phi_astar = phi1;
           break; 
        end
        
        % Third condition
        if (dphi1 >= 0)
           [astar, phi_astar] = zoom(meta, a1, phi1, dphi1, a0, phi0, dphi0);
           break;
        end
        
        a0 = a1;
        a1 = min(a1*2, amax); % From Python implementation

        phi0 = phi1;
        dphi0 = dphi1;
        phi1 = meta.phi(a1);
        dphi1 = meta.phi_deriv(phi1);
                
    end
    
    if i == max_iter
       warning('Line search did not converge');
       astar = 1;
    end
end

function [astar, phi_astar] = zoom(meta, alow, philow, dphilow, ahigh, phihigh, dphihigh)
    max_iter = 10;
    for j = 1:max_iter
        anew = cubicintp(alow, philow, dphilow, ahigh, phihigh, dphihigh);
        phinew = meta.phi(anew);
        dphinew = meta.phi_deriv(anew);

        if (phinew > (meta.phi_at0 + meta.C1*anew*meta.dphi_at0)) || (phinew >= philow)
            ahigh = anew;
            phihigh = phinew;
            dphihigh = dphinew;
        else
            if abs(dphinew) <= -meta.C2*meta.dphi_at0
               astar = anew;
               phi_astar = phinew;
               break;
            end
            if (dphinew*(ahigh - alow)) >= 0
                ahigh = alow;
                phihigh = philow;
                dphihigh = dphilow;
            end
            alow = anew;
            philow = phinew;
            dphilow = dphinew;
        end
        
        if j == max_iter
            astar = 1;
            phi_astar = 0;
        end
    end
end

function a = cubicintp(a0, phi0, dphi0, a1, phi1, dphi1)
    d1 = dphi0 + dphi1 - 3*(phi0 - phi1)/(a0 - a1);
    d2 = sign(a1 - a0)*sqrt(d1^2 - dphi0*dphi1);
    
    a = a1 - (a1 - a0)*((dphi1 + d2 - d1)/(dphi1 - dphi0 + 2*d2));
end
