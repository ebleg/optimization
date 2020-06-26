t = linspace(0, 10e-3, 10);
omega = linspace(0, 150, 10);
nlayers = 4;

run params

par.accu.ncells = 60;

[trng, omegarng] = meshgrid(t, omega);
cost = nan(size(trng));

for i = 1:numel(trng)
    cost(i) = combinedModel(omegarng(i), trng(i), nlayers, par);
end

mesh(trng, omegarng, cost)
