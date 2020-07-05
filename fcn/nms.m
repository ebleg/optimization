function [xopt] = nms(fcn,x0)

% Initial simplex
dim = length(x0);                  % Number of design variables
step = 1;                          % Steplength between other vertices of initial simplex and vertex x0
x = zeros(dim, dim+1);             % Coordinates of each vertex of the simplex
x(:,1) = x0;                       % Vertex 1 is equal to the initial guess
for i = 1:dim
    x(:, i+1) = x0;                % Set the coordinates of all other vertices to x0 as well
    x(i, i+1) = x(i,i+1) + step;   % The coordinates of all other vertices become 1 step away from x0
end

maxiteration = 1000;
iteration = 0;
previous = 10000;

while iteration < maxiteration
    
% Update scores of simplex vertices
scores = zeros(1,dim+1);
for i = 1 : dim+1
   scores(i) = fcn(x(:,i)); 
end

% Sort scores corresponding coordinates of simplex vertices from best to worst
[scores,idx] = sort(scores);
x = x(:, idx);

% Termination condition
maxerror = 0.000001;              % Same as fminsearch
if iteration > 0
    error = abs(scores(dim+1) - previous);
    if error < maxerror
        iteration
        display('Optimum found')
        break
    end
end
previous = scores(dim+1);

% Possible vertex positions
M = sum(x(:,1:dim)')'./dim;                     %   M = midpoint of all sides except for the worst 
R = 2*M - x(:,dim+1);                           %   R = reflection point

% Update cycle
if fcn(R) < fcn(x(:,dim)) && fcn(x(:,1)) <= fcn(R)                  
        x(:,dim+1) = R;
        display('Reflection 1)')
elseif fcn(R) < fcn(x(:,1))
    E = 2*R - M;                                    %   E = expansion point
    if fcn(E) < fcn(R)
            x(:,dim+1) = E;
            display('Expansion')
    else                           
            x(:,dim+1) = R;
            display('Reflection (2)')
    end
else % fcn(x(:,dim)) <= fcn(R)                                    
    if fcn(R) < fcn(x(:,dim+1))
       CR = (R - M)/2 + M;                             %   CR = contraction point on side of reflection point R
        if fcn(CR) < fcn(R)
            x(:,dim+1) = CR;
            display('Contraction outside')
        else % Shrink 
            S = (x(:,1) - x(:,dim+1))/2 + x(:,dim+1);       %   S = midpoint of the line between the best and worst vertex
            x(:,dim+1) = S;      
            x(:,dim) = M;  
            display('Shrink (1)')
        end
    else % fcn(x(:,dim+1) <= fcn(R) 
        CW = (M-x(:,dim+1))/2 + x(:,dim+1);             %   CW = contraction point on side worst vertex
        if fcn(CW) < fcn(R)     
            x(:,dim+1) = CW;
            display('Contraction inside')
        else
            S = (x(:,1) - x(:,dim+1))/2 + x(:,dim+1);       %   S = midpoint of the line between the best and worst vertex
            x(:,dim+1) = S;
            x(:,dim) = M;  
            display('Shrink (2)')
        end
    end
end

iteration = iteration + 1;

end

% Final values
xopt = [x(1,1) x(2,1)/1e4];
score_opt = scores(1);
<<<<<<< HEAD
iteration
toc;
=======

>>>>>>> 08a130adf120d04aa92d873c104a5f4c64247124
end
