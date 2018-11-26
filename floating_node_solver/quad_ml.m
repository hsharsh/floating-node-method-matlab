function [ml, area] = quad_ml(xvec,yvec,area,rho)
    xgp = sqrt(3/5)*[-1 0 1];
    wgp = [5 8 5]/9;
    ngp = length(xgp);
    ml = zeros(4*2);
    
    a = 0;

    for i = 1:ngp
        for j=1:ngp
            r = xgp(i); s = xgp(j);
            B1 = [ -(1-s)  (1-s) (1+s) -(1+s);
                 -(1-r)  -(1+r)  (1+r)  (1-r)]/4;
            jac(:,1) = (B1*xvec);
            jac(:,2) = (B1*yvec);
            a = a + det(jac)* wgp(i) * wgp(j);
        end
    end
    area = area + a;
    ml = (a/4)*rho*eye(4*2);
end