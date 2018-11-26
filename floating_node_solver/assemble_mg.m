area = 0;

for lmn = 1:nelm
    if elem(lmn).discont == 0
        nodes = elem(lmn).nodes;
        xvec = x(nodes,1);
        yvec = x(nodes,2);        
        
        [ml,area] = quad_ml(xvec,yvec,area,rho);
        ml = diag(ml);

        dof =  [
            nodes(1)*2-1 nodes(1)*2 ...
            nodes(2)*2-1 nodes(2)*2 ...
            nodes(3)*2-1 nodes(3)*2 ...
            nodes(4)*2-1 nodes(4)*2 ...
            ];
        dof;

        mg(dof) = mg(dof) + ml;
    else
        ml = zeros(size(dof,2));

        if size(elem(lmn).ex,1) == 2 && size(elem(lmn).ex,2) == 4  
            [ml1,area] = quad_ml(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,rho);
            [ml2,area] = quad_ml(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,rho);
            ml(1:8,1:8) = ml1;
            ml(9:16,9:16) = ml2;
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 3  
            [ml1,area] = tri_ml(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,rho);
            [ml2,area] = tri_ml(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,rho);
            [ml3,area] = tri_ml(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,rho);
            [ml4,area] = tri_ml(elem(lmn).ex(4,:)',elem(lmn).ey(4,:)',area,rho);            
            ml(1:6,1:6) = ml1;
            ml(7:12,7:12) = ml2;
            ml(13:18,13:18) = ml3;
            ml(19:24,19:24) = ml4;
        elseif size(elem(lmn).ex,1) == 3 && size(elem(lmn).ex,2) == 4  
            [ml1,area] = quad_ml(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,rho);
            [ml2,area] = quad_ml(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,rho);
            [ml3,area] = quad_ml(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,rho);        
            ml(1:8,1:8) = ml1;
            ml(9:16,9:16) = ml2;
            ml(17:24,17:24) = ml3;
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 4  
            [ml1,area] = quad_ml(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,rho);
            [ml2,area] = quad_ml(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,rho);
            [ml3,area] = quad_ml(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,rho);
            [ml4,area] = quad_ml(elem(lmn).ex(4,:)',elem(lmn).ey(4,:)',area,rho);            
            ml(1:8,1:8) = ml1;
            ml(9:16,9:16) = ml2;
            ml(17:24,17:24) = ml3;
            ml(25:32,25:32) = ml4;
        end

        ml = diag(ml);
        
        dof = elem(lmn).dof;
        mg(dof) = mg(dof) + ml;
    end

end
