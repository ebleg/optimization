%% PARAMETERS
par = struct();

%% LiOn cell dimensions
par.cell.r = 9.2e-3;  % Cell radius [m]
par.cell.d = 2e-3;   % Cell gap spacing [m] [ OPTIMIZATION VARIABLE ]
par.cell.l = 32.5e-3;  % Cell length [m]

par.channel.Ac = (4 - pi)*par.cell.r^2 ...
                 + par.cell.d^2 ...
                 + 4*par.cell.r*par.cell.d;
             
par.channel.P = 4*par.cell.d + 2*par.cell.r*pi;

par.channel.Dh = 4*par.channel.Ac/par.channel.P;

%% Battery package
par.accu.ncells = 420;
par.accu.nlayers = 5;

% Air properties at 310 K, 101325 Pa
par.air.rho = 1.141;   % Density
par.air.T = 310;       % Temperature
par.air.k = 0.0274;    % Thermal conductivity
par.air.cp = 1005;     % Specific heat @ constant pressure
par.air.mu = 18.87e-6; % Dynamic viscosity
par.air.nu = 16.54e-6; % Kinematic viscosity
par.air.Pr = .69;      % Prandtl number

