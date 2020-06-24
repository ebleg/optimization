function [xopt] = bfgs(fcn, x0, H0)
    % Initial guess for B
    B = inv(H0);
    
    if size(x0, 2) ~= 1
        x0 = x0';
    end
    
    n = size(x0, 2);
    
    g1 = jacobianest(fcn, x0)';
    
    % Convergence criterion
    eps = 1e-5;
    i = 0; converged = false;
    
    % Obtain search direction
    while ~converged && (i <= 200)
        p = -B*g1;

        a = fminbnd(@(a) fcn(x0 + a*p), 0, 3);
        s = a*p;
        x1 = x0 + s;

        g2 = jacobianest(fcn, x1)';
        y = g2 - g1;
        
        rho = 1/(y'*s);
        B = (eye(n) - rho*(s*y'))*B*(eye(n) - rho*(y*s')) + rho*(s*s');
        
        if norm(x1 - x0) < eps
            converged = true;
        end
        
        scatter(x0(1), x0(2), 'filled', 'blue');
        x0 = x1; i = i + 1; g1 = g2;
    end
    disp(i)
    xopt = x1;
end

