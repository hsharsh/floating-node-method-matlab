function [kl, area] = tri_kl(xvec,yvec,area,E,nu)
    a = det([1 1 1; xvec'; yvec'])/2;
    B1 = [  yvec(2)-yvec(3), yvec(3)-yvec(1), yvec(1)-yvec(2);
            xvec(3)-xvec(2), xvec(1)-xvec(3), xvec(2)-xvec(1)
    ]/(2*a);
    
    D = E/((1+nu)*(1-2*nu))*[1-nu 0 0; 0 1-nu 0; 0 0 1-2*nu];
    B2 = zeros(4,6);
    B2(1:2, 1:2:end) = B1;
    B2(3:4, 2:2:end) = B1;
    B0 = [1 0 0 0; 0 0 0 1; 0 1 1 0];
    B = B0*B2;
    kl = B'*D*B*a;
    area = area + a;
end