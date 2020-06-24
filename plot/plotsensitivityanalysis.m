% Plotting finite difference gradients

fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
xopt = [1,1];

[hx, dfdx1, dfdx2, ldfdx1, ldfdx2] = sensitivityanalysis(fun,xopt);

subplot(211)
semilogx(hx,dfdx1')
xlabel('Difference step hx'), ylabel('df/dx1'), title('Sensitivities objective function')

subplot(212)
semilogx(hx,dfdx2')
xlabel('Difference step hx'), ylabel('df/dx2'), title('Sensitivities objective function')

figure(2);
subplot(211)
semilogx(hx,ldfdx1')
xlabel('Difference step hx')

subplot(212)
semilogx(hx,ldfdx2')
xlabel('Difference step hx')