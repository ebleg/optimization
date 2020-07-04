function [y] = boundaryFcn(x, ubound, r)
    y = -(1/r)*log(max(0, ubound - x));
end