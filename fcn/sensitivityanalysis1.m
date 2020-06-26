function [hx, dfdx1, dfdx2] = sensitivityanalysis1(fnc,xopt)

% Central finite difference gradients of objective function for different
% perturbations

hx = logspace(-20,0,100); % Logarithmic perturbation set

for i=1:1:length(hx)
    
  % Central finite difference sensitivities
  fx1plus = fnc([xopt(1)+hx(i), xopt(2)]);
  fx1min = fnc([xopt(1)-hx(i), xopt(2)]);
  fx2plus = fnc([xopt(1), xopt(2)+hx(i)]);
  fx2min = fnc([xopt(1), xopt(2)-hx(i)]);
  dfdx1(i) = (fx1plus - fx1min)/(2*hx(i));
  dfdx2(i) = (fx2plus - fx1min)/(2*hx(i));
  
end

end

  



