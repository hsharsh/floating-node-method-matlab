function [cl, area] = quad_cl(xvec,yvec,area,eta,nu)
    xgp = sqrt(3/5)*[-1 0 1];
    wgp = [5 8 5]/9;
    ngp = length(xgp);
    cl = zeros(4*2);

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
            D = eta*ones(3);
            cl = cl + B'*D*B *det(jac) * wgp(i) * wgp(j);
            area = area + det(jac)* wgp(i) * wgp(j);
        end
    end
    % Ignore the code above this. Override for cl from the line below
    cl = eta*ones(8); 
end