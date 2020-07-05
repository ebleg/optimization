function [sensx1,sensx2] = sensitivityanalysis2(t,omega,fnc,x0,ht,homega)

% Central finite difference gradients of objective function for constant
% perturbation hx = 1e-8 and different values for the design variables.

for i = [1:1:length(t)]
  
  % dfdt
  fx1plus = fnc([t(i)+ht, x0(2)]);
  fx1min = fnc([t(i)-ht, x0(2)]);
  sensx1(i) = (fx1plus - fx1min)/(2*ht);
  
  % dfdw
  fx2plus = fnc([x0(1), omega(i)+homega]);
  fx2min = fnc([x0(1), omega(i)-homega]);
  sensx2(i) = (fx2plus - fx2min)/(2*homega);

end

end
