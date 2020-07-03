function [sensx1,sensx2] = sensitivityanalysis2(t,omega,fnc,x0)

% Central finite difference gradients of objective function for constant
% perturbation hx = 1e-8 and different values for the design variables.
% Goal: check monotonicity and convexity of objective function

hx = 1e-8;

for i = [1:1:length(t)]
  
  % x1
  fx1plus = fnc([t(i)+hx, x0(2)]);
  fx1min = fnc([t(i)-hx, x0(2)]);
  sensx1(i) = (fx1plus - fx1min)/(2*hx);
  
  % x2
  fx2plus = fnc([x0(1), omega(i)+hx]);
  fx2min = fnc([x0(1), omega(i)-hx]);
  sensx2(i) = (fx2plus - fx1min)/(2*hx);

end

end
