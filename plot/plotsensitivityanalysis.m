% Plotting finite difference gradients

fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
xopt = [1,1];

% Central finite difference gradients of objective function for different
% perturbations
[hx, dfdx1, dfdx2] = sensitivityanalysis1(fun,xopt);
figure(1);
subplot(211)
semilogx(hx,dfdx1')
xlabel('Difference step hx'), ylabel('df/dx1'), title('Sensitivities objective function')
subplot(212)
semilogx(hx,dfdx2')
xlabel('Difference step hx'), ylabel('df/dx2'), title('Sensitivities objective function')

% Central finite difference gradients of objective function for constant
% perturbation hx = 1e-8 and different values for the design variables.
[x1, x2, sensx1, sensx2] = sensitivityanalysis2(fun,xopt);
figure(2);
subplot(211)
plot(x1,sensx1')
xlabel('Design variable x1'), ylabel('df/dx1'), title('Sensitivities objective function')
subplot(212)
plot(x2,sensx2')
xlabel('Design variable x2'), ylabel('df/dx2'), title('Sensitivities objective function')

% Logarithmic sensitivity, used to compare the influence of the design
% variables
[x1, x2, logx1, logx2] = sensitivityanalysis3(fun,xopt);
figure(3);
subplot(211)
plot(x1,logx1')
xlabel('Design variable x1'), ylabel('(x1/f(x1,x2)*df/dx1'), title('Logarithmic sensitivities objective function')
subplot(212)
plot(x2,logx2')
xlabel('Design variable x2'), ylabel('(x1/f(x1,x2)*df/dx1'), title('Logarithmic sensitivities objective function')