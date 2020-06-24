function [xopt] = dfp(fcn, x0, H0)

    % Initial guess for B
    B1 = inv(H0);
    
    % Make sure x0 is column vector
    if size(x0, 2) ~= 1
        x1 = x0';
    end
    
    % gradient step 1
    g1 = findif(fcn, x1);
    
    % Convergence criterion
    eps = 1e-3;
    i = 0; converged = false;
    
    % Obtain search direction
    while ~converged && (i <= 1e4)
        
        s1 = -B1*g1;
        a1 = lineSearch(@(a1) fcn(x1 + a1*s1), [0 10]);
        
        x2 = x1 + a1*s1;
        g2 = findif(fcn, x2);
        
        dg = g2 - g1;
        dx = a1*s1;
        dB1 = (dx*dx')/(dx'*dg) - ((B1*dg)*(B1*dg)')/(dg'*(B1*dg));
        B2 = B1 + dB1;
        
        if norm(x2 - x1) < eps
            converged = true;
        end
        
        x1 = x2; 
        i = i + 1;
    end
       
    xopt = x2;

end