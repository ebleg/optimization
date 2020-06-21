run params
t = 2e-3;

figure

par.accu.ncells = 120;
plotBattery(t, 3, 1, par);

% subplot(122)
% par.accu.ncells = 120;
% plotBattery(t, 3, AR, par);