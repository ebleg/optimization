function [nch, stack, dim] = batteryLayout(t, nlayers, par)

    % Quick brute force optimization to find the closest to AR
    layercells = par.accu.ncells/nlayers;
    div = divisors(layercells); % all divisors of layercells are candidates for w and h
    optErr = inf;
    for w = div(2:end-1)
        h = layercells/w;
        if abs(h/w - par.accu.AR) < optErr % Better candidate combination
            wopt = w;
            optErr = abs(h/w - par.accu.AR); % set new error
        end
    end
    
    % Store stacking configuration
    stack.x = wopt;
    stack.y = layercells/wopt;
    stack.z = nlayers;
    
    % Store sizes as well
    dim.x = 2*stack.x*par.cell.r + (stack.x - 1)*t;
    dim.y = 2*stack.y*par.cell.r + (stack.y - 1)*t;
    dim.z = nlayers*par.cell.l;
    
    nch = round((stack.x - 1)*(stack.y - 1));

end

