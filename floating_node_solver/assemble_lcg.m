area = 0;

for lmn = 1:nelm
    if elem(lmn).discont == 0
        nodes = elem(lmn).nodes;
        xvec = x(nodes,1);
        yvec = x(nodes,2);        

        [cl,area] = quad_cl(xvec,yvec,area,eta);

        dof =  [
            nodes(1)*2-1 nodes(1)*2 ...
            nodes(2)*2-1 nodes(2)*2 ...
            nodes(3)*2-1 nodes(3)*2 ...
            nodes(4)*2-1 nodes(4)*2 ...
            ];
        v = vn(dof);
        lcg(dof) = lcg(dof) + (cl*v);       
    else
        cl = zeros(size(dof,2));

        if size(elem(lmn).ex,1) == 2 && size(elem(lmn).ex,2) == 4  
            [cl1,area] = quad_cl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,eta);
            [cl2,area] = quad_cl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,eta);
            cl(1:8,1:8) = cl1;
            cl(9:16,9:16) = cl2;
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 3  
            [cl1,area] = tri_cl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,eta);
            [cl2,area] = tri_cl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,eta);
            [cl3,area] = tri_cl(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,eta);
            [cl4,area] = tri_cl(elem(lmn).ex(4,:)',elem(lmn).ey(4,:)',area,eta);            
            cl(1:6,1:6) = cl1;
            cl(7:12,7:12) = cl2;
            cl(13:18,13:18) = cl3;
            cl(19:24,19:24) = cl4;
        elseif size(elem(lmn).ex,1) == 3 && size(elem(lmn).ex,2) == 4  
            [cl1,area] = quad_cl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,eta);
            [cl2,area] = quad_cl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,eta);
            [cl3,area] = quad_cl(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,eta);        
            cl(1:8,1:8) = cl1;
            cl(9:16,9:16) = cl2;
            cl(17:24,17:24) = cl3;
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 4  
            [cl1,area] = quad_cl(elem(lmn).ex(1,:)',elem(lmn).ey(1,:)',area,eta);
            [cl2,area] = quad_cl(elem(lmn).ex(2,:)',elem(lmn).ey(2,:)',area,eta);
            [cl3,area] = quad_cl(elem(lmn).ex(3,:)',elem(lmn).ey(3,:)',area,eta);
            [cl4,area] = quad_cl(elem(lmn).ex(4,:)',elem(lmn).ey(4,:)',area,eta);            
            cl(1:8,1:8) = cl1;
            cl(9:16,9:16) = cl2;
            cl(17:24,17:24) = cl3;
            cl(25:32,25:32) = cl4;
        end

        dof = elem(lmn).dof;
        v = vn(dof);
        lcg(dof) = lcg(dof) + (cl*v); 
    end

end