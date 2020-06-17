function [TcellsUpd] = updateCellTemp(Tcells, channels, stack, par)

TcellsUpd = Tcells;    

    for i = 1:stack.x
        for j = 1:stack.y
            for k = 1:stack.z   
                hcount = 0; vcount = 0;
                qcond = 0; qconv = 0;
                
                %% Horizontal boundary cases
                if j ~= stack.y % North
                    qcond = qcond + TcellsUpd(i, j+1, k)*par.cond.k_hor; 
                    hcount = hcount + 1;
                end
                if i ~= stack.x % East 
                    qcond = qcond + TcellsUpd(i+1, j, k)*par.cond.k_hor;
                    hcount = hcount + 1;
                end
                if j ~= 1 % South
                    qcond = qcond + TcellsUpd(i, j-1, k)*par.cond.k_hor;
                    hcount = hcount + 1;
                end
                if i ~= 1 % West
                    qcond = qcond + TcellsUpd(i-1, j, k)*par.cond.k_hor;
                    hcount = hcount + 1;
                end
                
                %% Vertical boundary cases
                if k ~= 1 % Lower
                    qcond = qcond + TcellsUpd(i, j, k-1)*par.cond.k_vert;
                    vcount = vcount + 1;
                end
                if k ~= stack.z % Upper
                    qcond = qcond + TcellsUpd(i, j, k+1)*par.cond.k_vert;
                    vcount = vcount + 1;
                end

                north = j == stack.y;
                south = j == 1;
                east = i == stack.x;
                west = i == 1;
                
                if ~south && ~west
                    qconv = qconv + 0.25*channels.q(i-1, j-1, k);
                end
                if ~north && ~east
                    qconv = qconv + 0.25*channels.q(i, j, k);
                end
                if ~north && ~west
                    qconv = qconv + 0.25*channels.q(i-1, j, k);
                end
                if ~south && ~east
                    qconv = qconv + 0.25*channels.q(i, j-1, k);
                end

                TcellsUpd(i, j, k) = (qcond - qconv + par.cell.qin)...
                                     /(hcount*par.cond.k_hor + vcount*par.cond.k_vert);
                                                                 
            end
        end
    end
end

