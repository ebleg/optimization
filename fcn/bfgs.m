function [xopt] = bfgs(fcn, x0)
    % Initial guess for B
    N = numel(x0);
    B = eye(N);
    
    if size(x0, 2) ~= 1
        x0 = x0';
    end
    
    f0 = fcn(x0);
    g0 = findif(fcn, x0, f0);
    
    % Convergence criterion
    eps = 1e-5;
    i = 0; converged = false;
        
    % Obtain search direction
    while ~converged && (i <= 200)
        p = -B*(g0);
        
        [a, f1] = lineSearch2(@(alph) fcn(x0 + alph*p), 1e100, f0, p'*g0);
        x1 = x0 + a*p;
        
        g1 = findif(fcn, x1, f1);
      
        s = x1 - x0;
        y = g1 - g0;
        
        B = B + ((s'*y + y'*B*y)*(s*s'))/(s'*y)^2 - (B*y*s' + s*y'*B)/(s'*y);
                
        if norm(g1) < eps
            converged = true;
        end
        
        x0 = x1;
        f0 = f1;
        g0 = g1;
        i = i + 1;
    end
    xopt = x1;
end

