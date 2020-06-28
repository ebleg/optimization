clear all; close all; clc;

% plot nms

% Rosenbrock's function
fcn = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
x0 = [1 1];

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
scores = zeros(1,dim+1);
for i = 1 : dim+1
   scores(i) = fcn(x(:,i)); 
end

% Sort scores corresponding coordinates of simplex vertices from best to worst
[scores,idx] = sort(scores);
x = x(:, idx);
scores;

M = sum(x(:,1:dim)')'./dim;                     %   M = midpoint of all sides except for the worst 
R = 2*M - x(:,dim+1);                           %   R = reflection point
E = 2*R - M;                                    %   E = expansion point
CR = (R - M)/2 + M;                             %   CR = contraction point on side of reflection point R
CW = (M-x(:,dim+1))/2 + x(:,dim+1);             %   CW = contraction point on side worst vertex
S = (x(:,1) - x(:,dim+1))/2 + x(:,dim+1);       %   S = midpoint of the line between the best and worst vertex

run defaultPlotSettings

figure;
p1 = plot(x(1,1),x(2,1),'ks','LineWidth',2,'DisplayName','x1'); hold on; grid off;
axis([-1.2 2.7 -1.2 2.7]);
axis equal;
p2 = plot(x(1,dim),x(2,dim),'kv','DisplayName','x1','LineWidth',2);
p3 = plot(x(1,dim+1), x(2,dim+1),'ko','LineWidth',2);
p4 = plot(M(1),M(2),'kx','LineWidth',2); 
p5 = plot(R(1),R(2),'mx','LineWidth',2); 
p6 = plot(E(1),E(2),'cx','LineWidth',2);
p7 = plot(CR(1),CR(2),'bx','LineWidth',2); 
p8 = plot(CW(1),CW(2),'rx','LineWidth',2);
p9 = plot(S(1),S(2),'gx','LineWidth',2);
plot([x(1,1) x(1,dim)],[x(2,1) x(2,dim)],'k');
plot([x(1,1) x(1,dim+1)],[x(2,1) x(2,dim+1)],'k');
plot([x(1,dim+1) x(1,dim)],[x(2,dim+1) x(2,dim)],'k');
plot([x(1,1) R(1)],[x(2,1) R(2)],'m--');
plot([x(1,dim) R(1)],[x(2,dim) R(2)],'m--');
plot([x(1,1) E(1)],[x(2,1) E(2)],'c--');
plot([x(1,dim) E(1)],[x(2,dim) E(2)],'c--');
plot([x(1,1) CR(1)],[x(2,1) CR(2)],'b--');
plot([x(1,dim) CR(1)],[x(2,dim) CR(2)],'b--');
plot([x(1,1) CW(1)],[x(2,1) CW(2)],'r--');
plot([x(1,dim) CW(1)],[x(2,dim) CW(2)],'r--');
plot([M(1) S(1)],[M(2) S(2)],'g--');
legend([p1 p2 p3 p4 p5 p6 p7 p8 p9],{'$\mathbf{x_{1}}$','$\mathbf{x_{2}}$','$\mathbf{x_{3}}$','$\mathbf{x_{centroid}}$','$\mathbf{x_{r}}$','$\mathbf{x_{e}}$','$\mathbf{x_{c-outside}}$','$\mathbf{x_{c-inside}}$','$\mathbf{x_{s}}$'});




