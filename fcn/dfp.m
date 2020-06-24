function [xopt] = dfp(fcn, x1, H0)

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
        a1 = lineSearch(@(a) fcn(x1 + a1*s1), [0 10]);
        x2 = x1 + a1*s1;
        
        g2 = findif(fcn, x2);
        y = g2 - g1;
        
        B1 = B1 + (s'*y + y'*B1*y)/(s'*y)^2 - (B1*y*s' + s*y'*B1)/(s'*y);
        
        if norm(x1 - x1) < eps
            converged = true;
        end
        
        x1 = x1; i = i + 1;
    end
       
    xopt = x1;

end