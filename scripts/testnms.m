% Test Nelder-Mead Simplex Optimization Algorithm
clear all; close all; clc;

% Rosenbrock's function
fun = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [-2.9723 0.1679];

%% Benchmark: minimize Rosenbrock's function using fminsearch
% fminsearch uses the Nelder-Mead Simplex algorithm
% 
% options = optimset('Display','iter','PlotFCns',@optimplotfval);
% [x,fval, exitflag, output] = fminsearch(fun,x0,options);

%% Self implemented Nelder-Mead Simplex optimization algorithm
% Used to minimize Rosenbrock's function

% References:
% https://github.com/t-k-/nelder-mead-simplex/blob/master/nelder_mead_simplex.m

% Visualization
	[X,Y] = meshgrid(-2.2:0.2:2.2, -2.8:0.2:6);
	Z = zeros(size(X));
	for i = 1:numel(X)
		Z(i) = fun([X(i) Y(i)]');
	end
	hold on; grid on;
	mesh(X, Y, Z)
	alpha(0.3)
	contour(X, Y, Z)
	color = [1 0 0]';

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

maxsteps = 10000;
cntstep = 0;
prevW = 10000;

while cntstep < maxsteps
    
% Visualization
		color = circshift(color, 2);
		fill3(x(1,:), x(2,:), [0 0 0], color')
    
% Update scores of simplex vertices
scores = zeros(1,dim+1);
for i = 1 : dim+1
   scores(i) = fun(x(:,i)); 
end
scores;

% Sort scores corresponding coordinates of simplex vertices from best to worst
[scores,idx] = sort(scores);
x = x(:, idx);
scores;

% Termination condition
maxerror = 0.0001;              % Same as fminsearch
if cntstep > 0
    error = abs(scores(dim+1) - prevW);
    if error < maxerror
        cntstep
        display('Optimum found')
        break
    end
end
prevW = scores(dim+1);

% Possible vertex positions
M = sum(x(:,1:dim)')'./dim;                     %   M = midpoint of all sides except for the worst 
R = 2*M - x(:,dim+1);                           %   R = reflection point
E = 2*R - M;                                    %   E = expansion point
CW = (M-x(:,dim+1))/2 + x(:,dim+1);             %   CW = contraction point on side worst vertex
CR = (R - M)/2 + M;                             %   CR = contraction point on side of reflection point R
S = (x(:,1) - x(:,dim+1))/2 + x(:,dim+1);       %   S = midpoint of the line between the best and worst vertex

scores3W = fun(x(:,dim+1));
scores2G = fun(x(:,dim));
scores1B = fun(x(:,1));
scores4R = fun(R);
scores5E = fun(E);
scores6CW = fun(CW);
scores7CR = fun(CR);
scores8S = fun(S);

% % Check: plot different points
% plot(x(1,1),x(2,1),'r*');
% hold on; grid on;
% plot(x(1,2),x(2,2),'r*');
% plot(x(1,3),x(2,3),'r*');
% axis equal;
% plot(M(1),M(2),'bo','LineWidth',2);
% plot(R(1),R(2),'go','LineWidth',2);
% plot(E(1),E(2),'ko','LineWidth',2);
% plot(CW(1),CW(2),'co','LineWidth',2);
% plot(CR(1),CR(2),'yo','LineWidth',2);
% plot(S(1),S(2),'mo','LineWidth',2);

% Update cycle
if fun(R) < fun(x(:,dim)) && fun(x(:,1)) <= fun(R)                  
        x(:,dim+1) = R;
        display('Reflection (B < R < G)')
elseif fun(R) < fun(x(:,1))
    if fun(E) < fun(R)
            x(:,dim+1) = E;
            display('Expansion')
    else                           
            x(:,dim+1) = R;
            display('Reflection (R < B)')
    end
else % fun(x(:,dim)) <= fun(R)                                    
    if fun(R) < fun(x(:,dim+1))
        if fun(CR) < fun(R)
            x(:,dim+1) = CR;
            display('Contraction outside')
        else % Shrink 
            x(:,dim+1) = S;      
            x(:,dim) = M;  
            display('Shrink (1)')
        end
    else % fun(x(:,dim+1) <= fun(R) 
        if fun(CW) < fun(R)     
            x(:,dim+1) = CW;
            display('Contraction inside')
        else
            x(:,dim+1) = S;      
            x(:,dim) = M;  
            display('Shrink (2)')
        end
    end
end

cntstep = cntstep + 1;

end

% Final values
x_opt = x(:,1)
score_opt = scores(1)




