function [xopt] = bfgs(fcn, x0, H0)
    % Initial guess for B
    B = inv(H0);
    
    if size(x0, 2) ~= 1
        x0 = x0';
    end
    
    g1 = findif(fcn, x0);
    
    % Convergence criterion
    eps = 1e-3;
    i = 0; converged = false;
    
    % Obtain search direction
    while ~converged && (i <= 1e4)
        p = B*g1;
        
        a = lineSearch(@(a) fcn(x0 + a*p), [0 10]);
        s = a*p;
        x1 = x0 + s;
        
        g2 = findif(fcn, x1);
        y = g2 - g1;
        
        B = B + (s'*y + y'*B*y)/(s'*y)^2 - (B*y*s' + s*y'*B)/(s'*y);
        
        if norm(x1 - x0) < eps
            converged = true;
        end
        
        x0 = x1; i = i + 1;
    end
       
    xopt = x1;
end

