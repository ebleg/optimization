%% ENGINEERING OPTIMIZATION PROJECT

close all; clear; clc;

run params

% plotConfiguration(par);
% 
% %% Check turbulent vs laminar
% G_turb = 1e4*par.air.mu/par.channel.Dh;
% G_lam = 23e2*par.air.mu/par.channel.Dh;
% 
% fprintf("Laminar u < %2.2f [m/s]\n", G_lam/par.air.rho);
% fprintf("Turbulent: u > %2.2f [m/s]\n", G_turb/par.air.rho);
% 
% %% Surface roughness checks
% ph = par.cell.l/par.cell.r;
% if (ph > 2 && ph < 6.3)
%    ks = par.cell.r*exp(3.4 - 3.7*(ph)^(-0.73)); 
% elseif (ph >= 6.3 && ph < 20)
%    ks = par.cell.r*exp(3.4 - 0.42*(ph)^(0.46)); 
% end
% 
% ub = 4.84;
% ReD = ub*par.air.rho*par.channel.Dh/par.air.mu;
% tmp = ks/(par.channel.Dh/2);
% f = (-2*log10(tmp/7.4 - 5.02/ReD*log10(tmp/7.4 + 13/ReD)))^(-2);
% ksplus = ub*ks/par.air.nu*(f/8)^(0.5);
% % channel is fully rough!

t = linspace(0, 5e-3, 100);
[Dh, ~, ~] = voidGeometry(t, par);

figure
plotBattery(2e-3, 6, 1, par);



