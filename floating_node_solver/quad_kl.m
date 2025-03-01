function [kl, area] = quad_kl(xvec,yvec,area,E,nu)
    xgp = sqrt(3/5)*[-1 0 1];
    wgp = [5 8 5]/9;
    ngp = length(xgp);
    kl = zeros(4*2);
    
    for i = 1:ngp
        for j=1:ngp
            r = xgp(i); s = xgp(j);
            B1 = [ -(1-s)  (1-s) (1+s) -(1+s);
                 -(1-r)  -(1+r)  (1+r)  (1-r)]/4;
            jac(:,1) = (B1*xvec);
            jac(:,2) = (B1*yvec);
            Bjac(1:2,1:2) = inv(jac);
            Bjac(3:4,3:4) = inv(jac);
            B0 = [1 0 0 0; 0 0 0 1; 0 1 1 0];
            B3 = zeros(4,8);
            B3(1:2, 1:2:end) = B1;
            B3(3:4, 2:2:end) = B1;
            B = B0*Bjac*B3;
            D = E/((1+nu)*(1-2*nu))*[1-nu 0 0; 0 1-nu 0; 0 0 1-2*nu];
            kl = kl + B'*D*B *det(jac) * wgp(i) * wgp(j);
            area = area + det(jac)* wgp(i) * wgp(j);
        end
    end
end