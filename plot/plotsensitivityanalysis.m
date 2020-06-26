function [] = plotSensitivityAnalysis(fnc,xopt)

% Central finite difference gradients of objective function for different
% perturbations
[hx, dfdx1, dfdx2] = sensitivityanalysis1(fnc,xopt);
figure(1);
subplot(211)
semilogx(hx,dfdx1')
xlabel('Difference step $hx$'), ylabel('$\frac{df}{dx_{1}}$'), title('Sensitivities objective function')
subplot(212)
semilogx(hx,dfdx2')
xlabel('Difference step $hx$'), ylabel('$\frac{df}{dx_{2}}$'), title('Sensitivities objective function')

% Central finite difference gradients of objective function for constant
% perturbation hx = 1e-8 and different values for the design variables.
[x1, x2, sensx1, sensx2] = sensitivityanalysis2(fnc,xopt);
figure(2);
subplot(211)
plot(x1,sensx1')
xlabel('Design variable $x_{1}$'), ylabel('$\frac{df}{dx_{1}}$'), title('Sensitivities objective function')
subplot(212)
plot(x2,sensx2')
xlabel('Design variable $x_{2}$'), ylabel('$\frac{df}{dx_{2}}$'), title('Sensitivities objective function')

% Logarithmic sensitivity, used to compare the influence of the design
% variables
[x1, x2, logx1, logx2] = sensitivityanalysis3(fnc,xopt);
figure(3);
subplot(211)
plot(x1,logx1')
xlabel('Design variable $x_{1}$'), ylabel('$\frac{x_{1}}{f}\frac{df}{dx_{1}}$'), title('Logarithmic sensitivities objective function')
subplot(212)
plot(x2,logx2')
xlabel('Design variable $x_{2}$'), ylabel('$\frac{x_{2}}{f}\frac{df}{dx_{2}}$'), title('Logarithmic sensitivities objective function')

end