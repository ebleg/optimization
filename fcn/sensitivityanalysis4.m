function [dfdtdt, dfdtdw, dfdwdt, dfdwdw] = sensitivityanalysis4(t,omega,fnc,x0,ht,homega)

% Central finite difference gradients of objective function for constant
% perturbation hx = 1e-8 and different values for the design variables.

for i = 1:length(t)
  for j = 1:length(omega)
  
  % df/(dt*dw)
  dfdtdw(i,j) = (fnc([(t(i)+ht),(omega(i)+homega)]) - fnc([(t(i)+ht),(omega(i)-homega)]) - fnc([(t(i)-ht),(omega(i)+homega)]) + fnc([(t(i)-ht),(omega(i)-homega)]))/(4*ht*homega);
  
  % df/(dw*dt)
  dfdwdt = dfdtdw;
 
  end
end

dfdtdt = zeros(1,10);

    for j = 1:length(t)
  
  % df/(dt*dt)
  dfdtdt(i) = (fnc([(t(i)+ht),x0(2)]) - 2*fnc([(t(i)),(x0(2))]) + fnc([(t(i)-ht),(x0(2))]))/(ht*ht);
  
  % df/(dw*dw)
  dfdwdw(i,j) = (fnc([(t(i)),(omega(i)+homega)]) - 2*fnc([(t(i)),(omega(i))]) + fnc([(t(i)),(omega(i)-homega)]))/(homega*homega);

end

% for i = 1:length(t)
%     for j = 1:length(omega)
%   
%   % df/(dt*dt)
%   dfdtdt(i,j) = (fnc([(t(i)+ht),omega(i)]) - 2*fnc([(t(i)),(omega(i))]) + fnc([(t(i)-ht),(omega(i))]))/(ht*ht);
%   
%   % df/(dt*dw)
%   dfdtdw(i,j) = (fnc([(t(i)+ht),(omega(i)+homega)]) - fnc([(t(i)+ht),(omega(i)-homega)]) - fnc([(t(i)-ht),(omega(i)+homega)]) + fnc([(t(i)-ht),(omega(i)-homega)]))/(4*ht*homega);
%   
%   % df/(dw*dt)
%   dfdwdt = dfdtdw;
%   
%   % df/(dw*dw)
%   dfdwdw(i,j) = (fnc([(t(i)),(omega(i)+homega)]) - 2*fnc([(t(i)),(omega(i))]) + fnc([(t(i)),(omega(i)-homega)]))/(homega*homega);
% 
%     end
% end

end
