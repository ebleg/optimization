function [xopt] = dfp(fcn, x0, H0)

 % Initial guess for B
    B = inv(H0);
    
    if size(x0, 2) ~= 1
        x0 = x0';
    end
    
    I = eye(size(x0, 2));
    
    g0 = findif(fcn, x0);
    
    % Convergence criterion
    eps = 1e-5;
    i = 0; converged = false;
    
    scatter(x0(1), x0(2));
    
    oldphi = fcn(x0) + 0.5*norm(g0);
    
    % Obtain search direction
    while ~converged && (i <= 200)
        p = -B*(g0);

        [a, oldphi] = lineSearch2(@(alph) fcn(x0 + alph*p), 1e100, oldphi);
        x1 = x0 + a*p;
        g1 = findif(fcn, x1);

        scatter(x1(1), x1(2));
        
        dx = x1 - x0;
        dg = g1 - g0;
        
%         rho = 1/(y'*s);
%         B = (I - rho*(s*y'))*B*(I - rho*(y*s')) + rho*(s*s');

        B = B + (dx*dx')/(dx'*dg) - ((B*dg)*(B*dg)')/(dg'*(B*dg));
                
        if norm(g1) < eps
            converged = true;
        end
        
        x0 = x1;
        g0 = g1;
        i = i + 1; 
    end
    xopt = x1;       

end