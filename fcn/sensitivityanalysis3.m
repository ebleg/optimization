function [] = sensitivityanalysis3(fnc,xopt)

% Determine logarithmic sensitivities in order to determine the importance 
% of the different design variables relative to each other. 

hx = 1e-8;

% ldfdx1(i) = (xopt(1)/fnc([xopt(1),xopt(2)])) * dfdx1(i);
% ldfdx2(i) = (xopt(2)/fnc([xopt(1),xopt(2)])) * dfdx2(i);

end
