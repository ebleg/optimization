function [ax] = plotConfiguration(par)
% Simple plot of the accu configuration

    figure;
    hold on;
    ax = gca;
    
    t = linspace(0, pi/2, 100);

    r = par.cell.r;
    H = r + par.cell.d/2;

    plot(ax, -H + r*cos(t), -H + r*sin(t), 'LineWidth', 3, 'Color', 'b');
    plot(ax, H - r*cos(t), -H + r*sin(t), 'LineWidth', 3, 'Color', 'b');
    plot(ax, H - r*cos(t), H - r*sin(t), 'LineWidth', 3, 'Color', 'b');
    plot(ax, -H + r*cos(t), H - r*sin(t), 'LineWidth', 3, 'Color', 'b');
    
    axis square;
    xlim([-H, H]);
    ylim([-H, H]);
    
    grid; grid minor;
end

