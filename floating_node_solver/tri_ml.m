function [ml, area] = tri_ml(xvec,yvec,area,rho)
    a = det([1 1 1; xvec'; yvec'])/2;
    ml = (a/3)*rho*eye(3*2);
end