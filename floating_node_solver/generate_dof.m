function [dof,nodi,M] = generate_dof_mod(nodes,edge,M,nodi)
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

            if isKey(M, nodes(mod(p+2,4)+1)*1e10+nodes(p))
                x = M(nodes(mod(p+2,4)+1)*1e10+nodes(p));
                n1 = [x(1)-1 x(1)];
                n2 = [x(2)-1 x(2)];
            elseif isKey(M, nodes(p)*1e10+nodes(mod(p+2,4)+1))
                x = M(nodes(p)*1e10+nodes(mod(p+2,4)+1));
                n1 = [x(2)-1 x(2)];
                n2 = [x(1)-1 x(1)];
            else    
                n1 = [nodi nodi+1];
                n2 = [nodi+2 nodi+3];
                M(nodes(mod(p+2,4)+1)*1e10+nodes(p)) = [nodi+1 nodi+3];
                nodi = nodi+4;
            end


            if isKey(M, nodes(p)*1e10+nodes(mod(p,4)+1))
                x = M(nodes(p)*1e10+nodes(mod(p,4)+1));
                n3 = [x(1)-1 x(1)];
                n4 = [x(2)-1 x(2)];
            elseif isKey(M, nodes(mod(p,4)+1)*1e10+nodes(p))
                x = M(nodes(mod(p,4)+1)*1e10+nodes(p));
                n3 = [x(2)-1 x(2)];
                n4 = [x(1)-1 x(1)];
            else    
                n3 = [nodi nodi+1];
                n4 = [nodi+2 nodi+3];
                M(nodes(p)*1e10+nodes(mod(p,4)+1)) = [nodi+1 nodi+3];
                nodi = nodi+4;
            end
            dof = [ nodes(mod(p+2,4)+1)*2-1, nodes(mod(p+2,4)+1)*2, n1, nodes(mod(p+1,4)+1)*2-1, nodes(mod(p+1,4)+1)*2, ...
                    n1, n4, nodes(mod(p+1,4)+1)*2-1, nodes(mod(p+1,4)+1)*2, ...
                    n4, nodes(mod(p,4)+1)*2-1, nodes(mod(p,4)+1)*2, nodes(mod(p+1,4)+1)*2-1, nodes(mod(p+1,4)+1)*2, ...
                    n2, nodes(p)*2-1, nodes(p)*2, n3  
            ];
        else
            if isKey(M, nodes(e)*1e10+nodes(mod(e,4)+1))
                x = M(nodes(e)*1e10+nodes(mod(e,4)+1));
                n1 = [x(1)-1 x(1)];
                n2 = [x(2)-1 x(2)];
            elseif isKey(M, nodes(mod(e,4)+1)*1e10+nodes(e))
                x = M(nodes(mod(e,4)+1)*1e10+nodes(e));
                n1 = [x(2)-1 x(2)];
                n2 = [x(1)-1 x(1)];
            else
                n1 = [nodi nodi+1];
                n2 = [nodi+2 nodi+3];
                M(nodes(e)*1e10+nodes(mod(e,4)+1)) = [nodi+1 nodi+3];
                nodi = nodi+4;
            end

            if isKey(M, nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1))
                x = M(nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1));
                n3 = [x(1)-1 x(1)];
                n4 = [x(2)-1 x(2)];
            elseif isKey(M, nodes(mod(e+2,4)+1)*1e10+nodes(mod(e+1,4)+1))
                x = M(nodes(mod(e+2,4)+1)*1e10+nodes(mod(e+1,4)+1));
                n3 = [x(2)-1 x(2)];
                n4 = [x(1)-1 x(1)];
            else
                n3 = [nodi nodi+1];
                n4 = [nodi+2 nodi+3];
                M(nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1)) = [nodi+1 nodi+3];
                nodi = nodi+4;
            end
            dof = [ nodes(e)*2-1, nodes(e)*2, n1, n4, nodes(mod(e+2,4)+1)*2-1, nodes(mod(e+2,4)+1)*2, ...
                    n2 nodes(mod(e,4)+1)*2-1, nodes(mod(e,4)+1)*2, nodes(mod(e+1,4)+1)*2-1, nodes(mod(e+1,4)+1)*2, n3
            ];
        end                      
    elseif length(find(edge(1,:)==1)) == 3 && length(find(edge(1,:)==2)) == 1
        e = find(edge(1,:)==2);

        if isKey(M, nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1))
            x = M(nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1));
            n1 = [x(1)-1 x(1)];
            n2 = [x(2)-1 x(2)];
        elseif isKey(M, nodes(mod(e+2,4)+1)*1e10+nodes(mod(e+1,4)+1))
            x = M(nodes(mod(e+2,4)+1)*1e10+nodes(mod(e+1,4)+1));
            n1 = [x(2)-1 x(2)];
            n2 = [x(1)-1 x(1)];
        else
            n1 = [nodi nodi+1];
            n2 = [nodi+2 nodi+3];
            M(nodes(mod(e+1,4)+1)*1e10+nodes(mod(e+2,4)+1)) = [nodi+1 nodi+3];
            nodi = nodi+4;
        end       

        if isKey(M, nodes(mod(e+2,4)+1)*1e10+nodes(e))
            x = M(nodes(mod(e+2,4)+1)*1e10+nodes(e));
            n3 = [x(1)-1 x(1)];
            n4 = [x(2)-1 x(2)];
        elseif isKey(M, nodes(e)*1e10+nodes(mod(e+2,4)+1))
            x = M(nodes(e)*1e10+nodes(mod(e+2,4)+1));
            n3 = [x(2)-1 x(2)];
            n4 = [x(1)-1 x(1)];
        else
            n3 = [nodi nodi+1];
            n4 = [nodi+2 nodi+3];
            M(nodes(mod(e+2,4)+1)*1e10+nodes(e)) = [nodi+1 nodi+3];
            nodi = nodi+4;
        end       

        if isKey(M, nodes(e)*1e10+nodes(mod(e,4)+1))
            x = M(nodes(e)*1e10+nodes(mod(e,4)+1));
            n5 = [x(1)-1 x(1)];
            n6 = [x(2)-1 x(2)];
        elseif isKey(M, nodes(mod(e,4)+1)*1e10+nodes(e))
            x = M(nodes(mod(e,4)+1)*1e10+nodes(e));
            n5 = [x(2)-1 x(2)];
            n6 = [x(1)-1 x(1)];
        else
            n5 = [nodi nodi+1];
            n6 = [nodi+2 nodi+3];
            M(nodes(e)*1e10+nodes(mod(e,4)+1)) = [nodi+1 nodi+3];
            nodi = nodi+4;
        end

        n7 = [nodi nodi+1];     nodi = nodi+2;
        n8 = [nodi nodi+1];     nodi = nodi+2;

        dof = [ nodes(mod(e+1,4)+1)*2-1, nodes(mod(e+1,4)+1)*2, n1, n7, n6, ...
                n2, nodes(mod(e+2,4)+1)*2-1, nodes(mod(e+2,4)+1)*2, n3, n8, ...
                n5, n4, nodes(e)*2-1, nodes(e)*2 , nodes(mod(e,4)+1)*2-1, nodes(mod(e,4)+1)*2 
        ];

    elseif length(find(edge(1,:)==1)) == 4
        if isKey(M, nodes(1)*1e10+nodes(2))
            x = M(nodes(1)*1e10+nodes(2));
            n1 = [x(1)-1 x(1)];
            n2 = [x(2)-1 x(2)];
        elseif isKey(M, nodes(2)*1e10+nodes(1))
            x = M(nodes(2)*1e10+nodes(1));
            n1 = [x(2)-1 x(2)];
            n2 = [x(1)-1 x(1)];
        else
            n1 = [nodi nodi+1];
            n2 = [nodi+2 nodi+3];
            M(nodes(1)*1e10+nodes(2)) = [nodi+1 nodi+3];
            nodi = nodi+4;
        end       

        if isKey(M, nodes(2)*1e10+nodes(3))
            x = M(nodes(2)*1e10+nodes(3));
            n3 = [x(1)-1 x(1)];
            n4 = [x(2)-1 x(2)];
        elseif isKey(M, nodes(3)*1e10+nodes(2))
            x = M(nodes(3)*1e10+nodes(2));
            n3 = [x(2)-1 x(2)];
            n4 = [x(1)-1 x(1)];
        else
            n3 = [nodi nodi+1];
            n4 = [nodi+2 nodi+3];
            M(nodes(2)*1e10+nodes(3)) = [nodi+1 nodi+3];
            nodi = nodi+4;
        end       

        if isKey(M, nodes(3)*1e10+nodes(4))
            x = M(nodes(3)*1e10+nodes(4));
            n5 = [x(1)-1 x(1)];
            n6 = [x(2)-1 x(2)];
        elseif isKey(M, nodes(4)*1e10+nodes(3))
            x = M(nodes(4)*1e10+nodes(3));
            n5 = [x(2)-1 x(2)];
            n6 = [x(1)-1 x(1)];
        else
            n5 = [nodi nodi+1];
            n6 = [nodi+2 nodi+3];
            M(nodes(3)*1e10+nodes(4)) = [nodi+1 nodi+3];
            nodi = nodi+4;
        end
        if isKey(M, nodes(4)*1e10+nodes(1))
            x = M(nodes(4)*1e10+nodes(1));
            n7 = [x(1)-1 x(1)];
            n8 = [x(2)-1 x(2)];
        elseif isKey(M, nodes(1)*1e10+nodes(4))
            x = M(nodes(1)*1e10+nodes(4));
            n7 = [x(2)-1 x(2)];
            n8 = [x(1)-1 x(1)];
        else
            n7 = [nodi nodi+1];
            n8 = [nodi+2 nodi+3];
            M(nodes(4)*1e10+nodes(1)) = [nodi+1 nodi+3];
            nodi = nodi+4;
        end

        n9  = [nodi nodi+1];     nodi = nodi+2;
        n10 = [nodi nodi+1];     nodi = nodi+2;
        n11 = [nodi nodi+1];     nodi = nodi+2;
        n12 = [nodi nodi+1];     nodi = nodi+2;

        dof = [ nodes(1)*2-1, nodes(1)*2, n1, n9, n8, ...
                n2, nodes(2)*2-1, nodes(2)*2, n3, n10, ...
                n11, n4, nodes(3)*2-1, nodes(3)*2, n5, ...
                n7, n12, n6, nodes(4)*2-1, nodes(4)*2
        ];

    end
end