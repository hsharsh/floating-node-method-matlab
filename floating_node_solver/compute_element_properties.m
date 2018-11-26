se = 0;

for lmn = 1:nelm
	% Gauss- Quadrature points and weights
	xgp = sqrt(3/5)*[-1 0 1];
    wgp = [5 8 5]/9;
    ngp = length(xgp);

    if elem(lmn).discont == 0
        nodes = elem(lmn).nodes;
        xvec = x(nodes,1);
        yvec = x(nodes,2);        

	    dof =  [
	        nodes(1)*2-1 nodes(1)*2 ...
	        nodes(2)*2-1 nodes(2)*2 ...
	        nodes(3)*2-1 nodes(3)*2 ...
	        nodes(4)*2-1 nodes(4)*2 ...
	    ];

	    u = un1(dof);
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
			    strain = B*u;
			    se = se + E * sum(strain.*strain) * det(jac) * wgp(i) * wgp(j);
			end
		end
    else
        dof = elem(lmn).dof;
        u = un1(dof);

        if size(elem(lmn).ex,1) == 2 && size(elem(lmn).ex,2) == 4
        	% Sum for all sub-elements
        	for k = 1:2
		        xvec = elem(lmn).ex(k,:)';	yvec = elem(lmn).ey(k,:)';
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
					    strain = B*u(8*(k-1)+1:8*k);
				    	se = se + E * sum(strain.*strain) * det(jac) * wgp(i) * wgp(j);
				    end
				end
			end
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 3  
        	% Sum for all sub-elements
        	for k = 1:4
		        xvec = elem(lmn).ex(k,:)';	yvec = elem(lmn).ey(k,:)';

	        	a = det([1 1 1; xvec'; yvec'])/2;
			    B1 = [  yvec(2)-yvec(3), yvec(3)-yvec(1), yvec(1)-yvec(2);
			            xvec(3)-xvec(2), xvec(1)-xvec(3), xvec(2)-xvec(1)
			    ]/(2*a);
			    
			    D = E*eye(3);
			    B2 = zeros(4,6);
			    B2(1:2, 1:2:end) = B1;
			    B2(3:4, 2:2:end) = B1;
			    B0 = [1 0 0 0; 0 0 0 1; 0 1 1 0];
			    B = B0*B2;
			 	strain = B*u(6*(k-1)+1:6*k);
				se = se + E*sum(strain.*strain)*a;
			end
        elseif size(elem(lmn).ex,1) == 3 && size(elem(lmn).ex,2) == 4  
        	% Sum for all sub-elements
        	for k = 1:3
		        xvec = elem(lmn).ex(k,:)';	yvec = elem(lmn).ey(k,:)';
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
					    strain = B*u(8*(k-1)+1:8*k);
				    	se = se + E * sum(strain.*strain) * det(jac) * wgp(i) * wgp(j);
				    end
				end
			end
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 4  
        	% Sum for all sub-elements
        	for k = 1:4
		        xvec = elem(lmn).ex(k,:)';	yvec = elem(lmn).ey(k,:)';
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
					    strain = B*u(8*(k-1)+1:8*k);
				    	se = se + E * sum(strain.*strain) * det(jac) * wgp(i) * wgp(j);
				    end
				end
			end		
        end
    end	
end