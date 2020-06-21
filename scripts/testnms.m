% Test Nelder-Mead Simplex Optimization Algorithm
clear all; close all; clc;

% Rosenbrock's function
fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [-1.2,1.1];

%% Benchmark: minimize Rosenbrock's function using fminsearch
% fminsearch uses the Nelder-Mead Simplex algorithm

options = optimset('Display','iter','PlotFCns',@optimplotfval);
[x,fval, exitflag, output] = fminsearch(fun,x0,options);

%% Self implemented Nelder-Mead Simplex optimization algorithm
% Used to minimize Rosenbrock's function

% References:
% https://github.com/t-k-/nelder-mead-simplex/blob/master/nelder_mead_simplex.m

% Initial simplex
dim = length(x0);                  % Number of design variables
step = 1;                          % Steplength between other vertices of initial simplex and vertex x0
x = zeros(dim, dim+1);             % Coordinates of each vertex of the simplex
scores = zeros(1, dim+1);          % Score for each vertex of the simplex
x(:,1) = x0;                       % Vertex 1 is equal to the initial guess
for i = 1:dim
    x(:, i+1) = x0;                % Set the coordinates of all other vertices to x0 as well
    x(i, i+1) = x(i,i+1) + step;   % The coordinates of all other vertices become 1 step away from x0
end

% Update scores of simplex vertices
for i = 1 : dim+1
   scores = fun(x(:,i)); 
end

% Sort scores corresponding coordinates of simplex vertices from best to worst
[scores,idx] = sort(scores);
x = x(:, idx);
scores;

% Termination condition
maxerror = 0.0001;
maxsteps = 99;
cntstep = 0;
if cntstep > 0
    error = scores(dim+1) - prevW;
    if error < maxerror
        cntstep
        display('Optimum found')
        break
    end
end
prevW = scores(dim+1);

% Convergence Control    
M = sum(x(:,1:dim)')'./dim;         %   M = midpoint of all sides except for the worst 
R = 2*M - x(:,dim+1);               %   R = reflection point
E = 2*R - M;                        %   E = expansion point
CW = (x(:,dim+1) + M)/2;            %   CW = contraction point on side worst vertex
CR = (R + M)/2;                     %   CR = contraction point on side of reflection point R
S = x(:,1) - x(:,dim+1);            %   S = midpoint of the line between the best and worst vertex

% C = smallest contraction point
if fun(CW) < fun(CR)
    C = CW;
else
    C = CR;

if fun(R) < fun(G)              % R is better than G
    if fun (B) < fun (R)        % R is better than G, but worse than B 
        W = R;
    else                        % R is better than G and B
        if F(E) < fun(B)        % R is better than G and B, and E is better than B as well
            W = E;
        else                    % R is better than G and B, but E is worse than B
            W = R;
        end
    end
else                            % R is worse than G
    if fun(R) < fun(W)          % R is worse than B, but better than W
        W = R;
        if fun(C) < fun(W)      % R is worse than B and better than W, and C is better than W
            W = C;      % Contraction
        else                    % R is worse than B and better than W, and C is worse than W
            W = S;      % Shrinking
            G = M;      % Shrinking
        end
    end
end

% Visualisation




