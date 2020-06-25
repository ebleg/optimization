function [xmax] = smoothmax(x, P)
    % Kreisselmeier-Steinhauser (KS) function for differentiable max
    % operator
    % https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19890007408.pdf
    N = numel(x); fmax = 450;
    xmax = fmax + (1/P)*log(1/N*sum(exp(P*x - fmax)));
end

