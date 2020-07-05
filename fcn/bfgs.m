function [xopt,count] = bfgs(fcn, x0, Hessupdate)
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
    count = 0; converged = false;

    % Obtain search direction
    while ~converged && (count <= 200)
        p = -B*(g0);
        
        [a, f1, df1] = lineSearch2(@(alph) fcn(x0 + alph*p), 1e100, f0, p'*g0);
        x1 = x0 + a*p;
        
        % Gradient at new point (f1 already calculated in line search)
        g1 = findif(fcn, x1, f1, p, df1);
      
        % Vectors for hessian update
        s = x1 - x0;
        y = g1 - g0;
        
        if Hessupdate            % Hessian update bfgs
            B = B + ((s'*y + y'*B*y)*(s*s'))/(s'*y)^2 - (B*y*s' + s*y'*B)/(s'*y);
        else                    % Hessian update dfp
            B = B + (s*s')/(s'*y) - ((B*y)*(B*y)')/(y'*(B*y));
        end
        
        if (norm(g1) < eps) || (norm(s) < 1e-10)
            converged = true;
        end
        
        x0 = x1;
        f0 = f1;
        g0 = g1;
        count = count + 1;
    end    
    xopt = x1;
end