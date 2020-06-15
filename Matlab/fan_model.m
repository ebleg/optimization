% Parameters
a = ;                   % Induction factor: non-dimensional parameter that quantifies the gain of velocity induced by the rotor
Cp = 4*a*((1-a)^2);
rho = 1.225;            % Air density [kg/m³] at 1013.25 hPa and 15°C

% Design variables
q;        % Flow [m3/s]
D;        % Diameter of fan [m]

% Power equation
P = (Cp*pi^2*rho*(q^3)*(D^4))/32;



