function [ht, homega, dfdt, dfdw] = sensitivityanalysis1(fnc,x0)

% Central finite difference gradients of objective function for different
% perturbations

ht = logspace(-20,0,100); % Logarithmic perturbation set
homega = logspace(-20,0,100); % Logarithmic perturbation set

for i=1:1:length(ht)
    
  % df/dt - Central finite difference sensitivities
  dfdtplus = fnc([x0(1)+ht(i), x0(2)]);
  dfdtmin = fnc([x0(1)-ht(i), x0(2)]);
  dfdt(i) = (dfdtplus - dfdtmin)/(2*ht(i));
  
  % df/dw - Central finite difference sensitivities
  dfdwplus = fnc([x0(1), x0(2)+homega(i)]);
  dfdwmin = fnc([x0(1), x0(2)-homega(i)]);
  dfdw(i) = (dfdwplus - dfdwmin)/(2*homega(i));
  
end

end

  



