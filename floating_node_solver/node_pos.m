function [ex, ey] = node_pos_mod(edge,xnodes,ynodes)
    x = zeros(1,4); y = zeros(1,4);
    for i = 1:4
        if(edge(2,i)==-1)
            x(i) = -1;  y(i) = -1;
        else
            x(i) = xnodes(i)*(1-edge(2,i))+xnodes(mod(i,4)+1)*edge(2,i);
            y(i) = ynodes(i)*(1-edge(2,i))+ynodes(mod(i,4)+1)*edge(2,i);
        end
    end
    
    if length(find(edge(1,:)==1)) == 2 && length(find(edge(1,:)==-1)) == 2  
        flag = 0;   p = -1; e = -1;
        for i = 1:4
            if edge(1,i) == 1 && edge(1,mod(i,4)+1) == 1  && ~flag
                flag = 1;   p = mod(i,4)+1;
            end
            if edge(1,i) == 1 && edge(1,mod(i+1,4)+1) == 1 && ~flag
                flag = 2;   e = i;
            end
        end
        if flag == 1
            ex = zeros(4,3); ey = zeros(4,3);
            ex(1,:) = [xnodes(mod(p+2,4)+1) x(mod(p+2,4)+1) xnodes(mod(p+1,4)+1)];
            ex(2,:) = [x(mod(p+2,4)+1) x(p) xnodes(mod(p+1,4)+1)];
            ex(3,:) = [x(p) xnodes(mod(p,4)+1) xnodes(mod(p+1,4)+1)];
            ex(4,:) = [x(mod(p+2,4)+1) xnodes(p) x(p)];
            ey(1,:) = [ynodes(mod(p+2,4)+1) y(mod(p+2,4)+1) ynodes(mod(p+1,4)+1)];
            ey(2,:) = [y(mod(p+2,4)+1) y(p) ynodes(mod(p+1,4)+1)];
            ey(3,:) = [y(p) ynodes(mod(p,4)+1) ynodes(mod(p+1,4)+1)];
            ey(4,:) = [y(mod(p+2,4)+1) ynodes(p) y(p)];
        else
            ex = zeros(2,4); ey = zeros(2,4);            
            ex(1,:) = [xnodes(e) x(e) x(mod(e+1,4)+1) xnodes(mod(e+2,4)+1)];
            ex(2,:) = [x(e) xnodes(mod(e,4)+1) xnodes(mod(e+1,4)+1) x(mod(e+1,4)+1)];
            ey(1,:) = [ynodes(e) y(e) y(mod(e+1,4)+1) ynodes(mod(e+2,4)+1)];
            ey(2,:) = [y(e) ynodes(mod(e,4)+1) ynodes(mod(e+1,4)+1) y(mod(e+1,4)+1)];
        end                      
    elseif length(find(edge(1,:)==1)) == 3 && length(find(edge(1,:)==2)) == 1
        e = find(edge(1,:)==2);
        xi = x(mod(e+2,4)+1)*(1-edge(2,e))+x(mod(e,4)+1)*edge(2,e);
        yi = y(mod(e+2,4)+1)*(1-edge(2,e))+y(mod(e,4)+1)*edge(2,e);
        ex = zeros(3,4); ey = zeros(3,4);
        ex(1,:) = [xnodes(mod(e+1,4)+1) x(mod(e+1,4)+1) xi x(mod(e,4)+1)];
        ex(2,:) = [x(mod(e+1,4)+1) xnodes(mod(e+2,4)+1) x(mod(e+2,4)+1) xi ];
        ex(3,:) = [x(mod(e,4)+1) x(mod(e+2,4)+1) xnodes(e) xnodes(mod(e,4)+1)];
        ey(1,:) = [ynodes(mod(e+1,4)+1) y(mod(e+1,4)+1) yi y(mod(e,4)+1)];
        ey(2,:) = [y(mod(e+1,4)+1) ynodes(mod(e+2,4)+1) y(mod(e+2,4)+1) yi ];
        ey(3,:) = [y(mod(e,4)+1) y(mod(e+2,4)+1) ynodes(e) ynodes(mod(e,4)+1)];
    elseif length(find(edge(1,:)==1)) == 4
        xi = ((x(1)*x(2)*y(4)+x(2)*x(3)*y(1)+x(3)*x(4)*y(2)+x(4)*x(1)*y(3))-(x(1)*y(2)*x(4)+x(2)*y(3)*x(1)+x(3)*y(4)*x(2)+x(4)*y(1)*x(3)))...
                /((x(1)*y(4)+x(2)*y(1)+x(3)*y(2)+x(4)*y(3))-(x(1)*y(2)+x(2)*y(3)+x(3)*y(4)+x(4)*y(1)));
        yi = ((y(1)*x(2)*y(4)+y(2)*x(3)*y(1)+y(3)*x(4)*y(2)+y(4)*x(1)*y(3))-(y(1)*y(2)*x(4)+y(2)*y(3)*x(1)+y(3)*y(4)*x(2)+y(4)*y(1)*x(3)))...
                /((x(1)*y(4)+x(2)*y(1)+x(3)*y(2)+x(4)*y(3))-(x(1)*y(2)+x(2)*y(3)+x(3)*y(4)+x(4)*y(1)));
        ex = zeros(4,4); ey = zeros(4,4);
        ex(1,:) = [xnodes(1) x(1) xi x(4)];
        ex(2,:) = [x(1) xnodes(2) x(2) xi];
        ex(3,:) = [xi x(2) xnodes(3) x(3)];
        ex(4,:) = [x(4) xi x(3) xnodes(4)];
        ey(1,:) = [ynodes(1) y(1) yi y(4)];
        ey(2,:) = [y(1) ynodes(2) y(2) yi];
        ey(3,:) = [yi y(2) ynodes(3) y(3)];
        ey(4,:) = [y(4) yi y(3) ynodes(4)];        
    end
end