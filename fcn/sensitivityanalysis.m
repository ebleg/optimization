function [hx, dfdx1, dfdx2, ldfdx1, ldfdx2] = sensitivityanalysis(fnc,xopt)

% Forward finite diffence gradients of objective function

hx = logspace(-20,0,100); % vector of finite difference steps

for i=1:1:length(hx)

  % Finite diffence step
  hxi = hx(i);

  % Central finite difference sensitivities
  fx1plus = fnc([xopt(1)+hxi, xopt(2)]);
  fx1min = fnc([xopt(1)-hxi, xopt(2)]);
  fx2plus = fnc([xopt(1), xopt(2)+hxi]);
  fx2min = fnc([xopt(1), xopt(2)-hxi]);
  dfdx1(i) = (fx1plus - fx1min)/(2*hxi);
  dfdx2(i) = (fx2plus - fx1min)/(2*hxi);
  
  % Logarithmic sensitivities
  ldfdx1(i) = (xopt(1)/fnc([xopt(1),xopt(2)])) * dfdx1(i);
  ldfdx2(i) = (xopt(2)/fnc([xopt(1),xopt(2)])) * dfdx2(i);


end

end



