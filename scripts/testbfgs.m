clear; close all;
figure; hold on;
axis equal;

f = @(x) (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2 ;

[X, Y] = meshgrid(-3:0.1:3, -3:0.1:3);
Z = nan(size(X));

for i = 1:numel(X)
    Z(i) = f([X(i), Y(i)]);
end

contour(X, Y, Z, linspace(0, 1000, 30));
grid; grid minor;

x0 = [-2.1 -2.7];
H0 = hessian(f, x0);
xopt = bfgs(f, x0, H0);

scatter(xopt(1), xopt(2), 'filled');


hold on;
