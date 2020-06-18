function [grad] = findif(fcn, x0, feval)
    % Use finite differences to compute the gradient of a function
    % feval can be used if there is already a function evaluation available
    % at point x0, as is usually the case.
    
    h = 1e-8;
    
    % Check whether feval is supplied or not
    if nargin == 2
        useFeval = false;
    else
        useFeval = true;
    end
    
    grad = nan(size(x0));
    
    for i=1:numel(x0)
        dist = zeros(size(x0));
        dist(i) = h; % Create disturbance vector
        
        if useFeval
            grad(i) = (fcn(x0 + dist) - feval)./h;
        else
            grad(i) = (fcn(x0 + dist) - fcn(x0))./h;
        end
    end
end

