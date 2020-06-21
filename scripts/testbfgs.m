f = @(x) (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2 ;

[X, Y] = meshgrid(-10:0.1:10, -10:0.1:10);
Z = nan(size(X));

for i = 1:numel(X)
    Z(i) = f([X(i), Y(i)]);
end

contour(X, Y, Z);

x0 = [3, 4];
H0 = hessian(f, x0);
xopt = bfgs(f, x0, H0);

hold on;
% contour(xopt(1), xopt(2), f(xopt));