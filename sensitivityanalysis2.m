function [x1, x2, sensx1,sensx2] = sensitivityanalysis2(fnc,xopt)

% Central finite difference gradients of objective function for constant
% perturbation hx = 1e-8 and different values for the design variables.
% Goal: check monotonicity and convexity of objective function

hx = 1e-8;
x1 = linspace(-1.5, 1.5, 100);
x2 = linspace(-1.5, 1.5, 100);

for i = [1:1:length(x1)]
  
  % x1
  fx1plus = fnc([x1(i)+hx, xopt(2)]);
  fx1min = fnc([x1(i)-hx, xopt(2)]);
  sensx1(i) = (fx1plus - fx1min)/(2*hx);
  
  % x2
  fx2plus = fnc([xopt(1), x2(i)+hx]);
  fx2min = fnc([xopt(1), x2(i)-hx]);
  sensx2(i) = (fx2plus - fx1min)/(2*hx);

end

end
