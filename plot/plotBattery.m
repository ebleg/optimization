function [] = plotBattery(t, nlayers, AR, par)
    % Cell coordinates
    [x1,y1,z1] = cylinder(par.cell.r);
    x1 = x1(:) + par.cell.r; 
    y1 = y1(:) + par.cell.r; % Battery corner should be at (0, 0, 0)
    z1 = z1(:)*par.cell.l;
    P = [x1 y1 z1];
    P = unique(P,'rows');
    grid on;
    hold on;
    
    % Spacing between cells
    dx = 2*par.cell.r + t;
    dy = 2*par.cell.r + t;
%     dz = par.cell.l + 1e-3; % Not physical
    dz = 0;
    
    % Compute layout
    [~, stack, size] = batteryLayout(t, nlayers, AR, par);
    
    % Plot all the cylinders
    for i = 0:(stack.x - 1)
        for j = 0:(stack.y - 1)
            for k = 0:(nlayers-1)
                shp = alphaShape(P(:,1) + i*dx,P(:,2) + j*dy,P(:,3) + k*dz,1);
                plot(shp);
            end
        end
    end  
    
    title('\textbf{Battery stacking configuration}', 'Interpreter', 'latex');
    xlabel('$x$ [m]', 'Interpreter', 'latex');
    ylabel('$y$ [m]', 'Interpreter', 'latex');
    zlabel('$z$ [m]', 'Interpreter', 'latex');
    
    str = sprintf('Dimensions [mm]\n  $x$: %.0f\n  $y$: %.0f\n  $z$: %.0f', size.x*1e3, size.y*1e3, size.z*1e3);
    dim = [.7 .5 .3 .3];
    annotation('textbox',dim,'String',str,'FitBoxToText','on', 'Interpreter', 'latex');
    
    axis equal;
    view(45, 45)
end

