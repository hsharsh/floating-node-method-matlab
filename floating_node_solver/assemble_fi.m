area = 0;

for lmn = 1:nelm
    if elem(lmn).discont == 0
        nodes = elem(lmn).nodes;
        xvec = x(nodes,1);
        yvec = x(nodes,2);        

        [kl,area] = quad_kl(xvec,yvec,area,E);

        dof =  [
            nodes(1)*2-1 nodes(1)*2 ...
            nodes(2)*2-1 nodes(2)*2 ...
            nodes(3)*2-1 nodes(3)*2 ...
            nodes(4)*2-1 nodes(4)*2 ...
            ];
        u = un(dof);
        fi(dof) = fi(dof) + (kl*u);       
    else
        kl = zeros(size(dof,2));

        if size(elem(lmn).ex,1) == 2 && size(elem(lmn).ex,2) == 4  
            [kl1,area] = quad_kl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,E);
            [kl2,area] = quad_kl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,E);
            kl(1:8,1:8) = kl1;
            kl(9:16,9:16) = kl2;
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 3  
            [kl1,area] = tri_kl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,E);
            [kl2,area] = tri_kl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,E);
            [kl3,area] = tri_kl(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,E);
            [kl4,area] = tri_kl(elem(lmn).ex(4,:)',elem(lmn).ey(4,:)',area,E);            
            kl(1:6,1:6) = kl1;
            kl(7:12,7:12) = kl2;
            kl(13:18,13:18) = kl3;
            kl(19:24,19:24) = kl4;
        elseif size(elem(lmn).ex,1) == 3 && size(elem(lmn).ex,2) == 4  
            [kl1,area] = quad_kl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,E);
            [kl2,area] = quad_kl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,E);
            [kl3,area] = quad_kl(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,E);        
            kl(1:8,1:8) = kl1;
            kl(9:16,9:16) = kl2;
            kl(17:24,17:24) = kl3;
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 4  
            [kl1,area] = quad_kl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,E);
            [kl2,area] = quad_kl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,E);
            [kl3,area] = quad_kl(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,E);
            [kl4,area] = quad_kl(elem(lmn).ex(4,:)',elem(lmn).ey(4,:)',area,E);            
            kl(1:8,1:8) = kl1;
            kl(9:16,9:16) = kl2;
            kl(17:24,17:24) = kl3;
            kl(25:32,25:32) = kl4;
        end

        dof = elem(lmn).dof;
        u = un(dof);
        fi(dof) = fi(dof) + (kl*u); 
    end

end