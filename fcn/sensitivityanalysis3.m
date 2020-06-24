function [x1, x2, logx1, logx2] = sensitivityanalysis3(fnc,xopt)

% Determine logarithmic sensitivities in order to determine the importance 
% of the different design variables relative to each other. 

hx = 1e-8;
x1 = linspace(-1.5, 1.5, 100);
x2 = linspace(-1.5, 1.5, 100);

for i = [1:1:length(x1)]
  
  % x1
  fx1 = fnc([x1(i), xopt(2)]);
  fx1plus = fnc([x1(i)+hx, xopt(2)]);
  fx1min = fnc([x1(i)-hx, xopt(2)]);
  logx1(i) = (x1(i)./fx1)*((fx1plus - fx1min)/(2*hx));
  
  % x2
  fx2 = fnc([xopt(1), x2(i)+hx]);
  fx2plus = fnc([xopt(1), x2(i)+hx]);
  fx2min = fnc([xopt(1), x2(i)-hx]);
  logx2(i) = (x2(i)./fx2)*((fx2plus - fx1min)/(2*hx));

end

end
