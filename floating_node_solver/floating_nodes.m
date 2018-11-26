for lmn = 1:nelm
    if elem(lmn).discont == 1
        nodes = elem(lmn).nodes;
        s = compute_num(M,nodes,elem(lmn).edges);
        [elem(lmn).ex, elem(lmn).ey] = node_pos(elem(lmn).edges,x(nodes,1),x(nodes,2));
        
        un = [un; zeros(s,1)];  un1 = [un1; zeros(s,1)];
        vn = [vn; zeros(s,1)];  vn1 = [vn1; zeros(s,1)];
        an1 = [an1; zeros(s,1)];
        fi = [fi; zeros(s,1)];
        fg = [fg; zeros(s,1)];
        mg = [mg; zeros(s,1)];
        lcg = [lcg; zeros(s,1)];

        [elem(lmn).dof,nodi,M] = generate_dof(nodes,elem(lmn).edges,M,nodi);
        un = update_un(elem(lmn).edges,un,elem(lmn).dof,x(nodes,1),x(nodes,2));

        elem(lmn).discont = 2;
    end
end
