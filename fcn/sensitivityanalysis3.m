function [logt, logomega] = sensitivityanalysis3(t,omega,fnc,x0,ht,homega)

% Determine logarithmic sensitivities in order to determine the importance 
% of the different design variables relative to each other. 

for i = [1:1:length(t)]
  
  % dfdt
  fx1 = fnc([t(i), x0(2)]);
  fx1plus = fnc([t(i)+ht, x0(2)]);
  fx1min = fnc([t(i)-ht, x0(2)]);
  logt(i) = (t(i)./fx1)*((fx1plus - fx1min)/(2*ht));
  
  % dfdw
  fx2 = fnc([x0(1), omega(i)+homega]);
  fx2plus = fnc([x0(1), omega(i)+homega]);
  fx2min = fnc([x0(1), omega(i)-homega]);
  logomega(i) = (omega(i)./fx2)*((fx2plus - fx1min)/(2*homega));

end

end
