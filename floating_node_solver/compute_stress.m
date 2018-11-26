function stress = compute_stress(r,s,xvec,yvec,u,E)
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
    strain = B*u;
    stress = [E 0 0; 0 E 0; 0 0 0.5*E]*strain;
 	%stress = E*sqrt(((stress(1)-stress(2))^2 + stress(1)^2 + stress(2)^2 +6*(stress(3)^2))/2);
end