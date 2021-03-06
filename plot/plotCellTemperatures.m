function [] = plotCellTemperatures(t, nlayers, Tcells, par)
    % Cell coordinates
    [x1,y1,z1] = cylinder(par.cell.r);
    x1 = x1(:) + par.cell.r; 
    y1 = y1(:) + par.cell.r; % Battery corner should be at (0, 0, 0)
    z1 = z1(:)*par.cell.l;
    P = [x1 y1 z1];
    P = unique(P,'rows');
    
    figure;
    
    % Spacing between cells
    dx = 2*par.cell.r + t;
    dy = 2*par.cell.r + t;
    dz = par.cell.l;
    
    % Compute layout
    [~, stack, size] = batteryLayout(t, nlayers, par);
    
    % Colormap values
    cmap = colormap;
    Tmin = min(Tcells, [], 'all');
    Tmax = max(Tcells, [], 'all');
    Tcolor = @(T) cmap(ceil((T - Tmin)/(Tmax - Tmin)*255 + 1), :);
    

    tl = tiledlayout(1, 2);
    nexttile; hold on;
    
    % Plot all the cylinders
    for i = 0:(stack.x - 1)
        for j = 0:(stack.y - 1)
            for k = 0:(nlayers-1)               
                shp = alphaShape(P(:,1) + i*dx,P(:,2) + j*dy,P(:,3) + k*dz,1);
                plot(shp, 'FaceColor', Tcolor(Tcells(i+1, j+1, k+1)), 'EdgeAlpha', 0.2, 'FaceLighting', 'gouraud', 'EdgeLighting', 'gouraud');
            end
        end
    end  
    
    xlabel('$x$ [m]');
    ylabel('$y$ [m]');
    zlabel('$z$ [m]');
    
    str = sprintf('Dimensions [mm]\n  $x$: %.0f\n  $y$: %.0f\n  $z$: %.0f', size.x*1e3, size.y*1e3, size.z*1e3);
    textboxdim = [.4 .5 .3 .3];
    annotation('textbox',textboxdim,'String',str,'FitBoxToText','on', 'Interpreter', 'latex');
    
    xlim([0, size.x]);
    ylim([0, size.y]);
    zlim([0, size.z]);
    axis equal;
    cb = colorbar('west', 'Ticks', linspace(0, 1, 10), 'TickLabels', round(linspace(0, 1, 10)*(Tmax - Tmin) + Tmin));    
    cb.TickLabelInterpreter = 'latex';
    title('Configuration view', 'FontSize', 16)

    view(45, 45);
    
    nexttile;
    histogram(Tcells);
    xlabel('Temperature [K]');
    ylabel('Number of cells [-]');
    title('Temperature distribution', 'FontSize', 16)

end

