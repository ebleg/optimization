function [channelsUpd] = updateChannelTemp(t, u, channels, Tcells, par)
    [xlen, ylen, zlen] = size(channels.T);
    
    channelsUpd = channels;

    for i = 1:xlen
        for j = 1:ylen
            for k = 1:zlen
                Ts = mean([Tcells(i, j, k), ...
                           Tcells(i+1, j+1, k), ...
                           Tcells(i, j+1, k), ...
                           Tcells(i+1, j, k)]);
                
                if k == 1
                    Te = par.air.T;
                else
                    Te = channels.T(i, j, k-1);
                end
                
                [q, To] = laminarDuct(t, Ts, Te, par.cell.l, u, par);
                
                channelsUpd.q(i, j, k) = q;
                channelsUpd.T(i, j, k) = To;
            end
        end
    end
end

