%% PARAMETERS
par = struct();

%% LiOn cell dimensions
par.cell.r = 9.2e-3;            % Cell radius [m]
par.cell.l = 65e-3;             % Cell length [m]
par.cell.T0 = 46 + 273.15;       % Cell temperature [K]
par.cell.qin = 0.1;

%% Channel
par.channel.Nu = 3.6;           % Square

%% Battery package
par.accu.ncells = 120;

%% Air properties at 310 K, 101325 Pa
par.air.rho = 1.177;            % Density
par.air.T = 300;                % Temperature
par.air.k = 0.0267;             % Thermal conductivity
par.air.cp = 1005;              % Specific heat @ constant pressure
par.air.mu = 18.43e-6;          % Dynamic viscosity
par.air.nu = 15.66e-6;          % Kinematic viscosity
par.air.Pr = .69;               % Prandtl number

%% Fan
% Based on fan used in NunaX: Noctua NF-A14 PWM, 140mm
par.fan.u1 = 0.039;         % Volumetric flow [m3/s]
par.fan.p1 = 1.56;          % Power [W]
par.fan.omega1 = 1500;      % RPM
par.fan.D1 = 0.14;          % Diameter fan [m]

%% Variable property correction exponents
par.correction.lam.m = 1;
par.correction.lam.n = 0;

par.correction.turb.m = -0.2;
par.correction.turb.n = -0.55;

%% Conduction coefficients
par.cond.k_vert = 0.1;
par.cond.k_hor = 0.1;

%% Size constraints
par.constraints.xwidth = 0.5;
par.constraints.ywidth = 0.3;
par.constraints.z = 0.4;