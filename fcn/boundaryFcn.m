function [y] = boundaryFcn(x, lbound, ubound, r)
    y = -(1/r)*log(max(0, ubound - x)) - (1/r)*log(max(0, x - lbound));
end

