function s = compute_num_mod(M,nodes,edge)
    s = 0;
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
            if ~isKey(M, nodes(mod(p+2,4)+1)*1e10+nodes(p)) && ~isKey(M, nodes(p)*1e10+nodes(mod(p+2,4)+1))
                s = s + 4;
            end

            if ~isKey(M, nodes(p)*1e10+nodes(mod(p,4)+1)) && ~isKey(M, nodes(mod(p,4)+1)*1e10+nodes(p))
                s = s + 4;
            end
        else
            if ~isKey(M, nodes(e)*1e10+nodes(mod(e,4)+1)) && ~isKey(M, nodes(mod(e,4)+1)*1e10+nodes(e))
                s = s + 4;
            end

            if ~isKey(M, nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1)) && ~isKey(M, nodes(mod(e+2,4)+1)*1e10+nodes(mod(e+1,4)+1))
                s = s + 4;
            end
        end                      
    elseif length(find(edge(1,:)==1)) == 3 && length(find(edge(1,:)==2)) == 1
        e = find(edge(1,:)==2);

        if ~isKey(M, nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1)) && ~isKey(M, nodes(mod(e+2,4)+1)*1e10+nodes(mod(e+1,4)+1))
            s = s + 4;
        end       

        if ~isKey(M, nodes(mod(e+2,4)+1)*1e10+nodes(e)) && ~isKey(M, nodes(e)*1e10+nodes(mod(e+2,4)+1))
            s = s + 4;
        end       

        if ~isKey(M, nodes(e)*1e10+nodes(mod(e,4)+1)) && ~isKey(M, nodes(mod(e,4)+1)*1e10+nodes(e))
            s = s + 4;
        end

        s = s + 4;

    elseif length(find(edge(1,:)==1)) == 4
        if ~isKey(M, nodes(1)*1e10+nodes(2)) && ~isKey(M, nodes(2)*1e10+nodes(1))
            s = s + 4;
        end       

        if ~isKey(M, nodes(2)*1e10+nodes(3)) && ~isKey(M, nodes(3)*1e10+nodes(2))
            s = s + 4;
        end       

        if ~isKey(M, nodes(3)*1e10+nodes(4)) && ~isKey(M, nodes(4)*1e10+nodes(3))
            s = s + 4;
        end
        if ~isKey(M, nodes(4)*1e10+nodes(1)) && ~isKey(M, nodes(1)*1e10+nodes(4))
            s = s + 4;
        end

        s = s + 8;

    end
end