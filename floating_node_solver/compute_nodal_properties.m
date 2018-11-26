stress = zeros(nnod,2);

for lmn = 1:nelm
	% Gauss- Quadrature points and weights
	rr = [1	-1 	-1	1];
	ss = [1	 1	-1 -1];

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
	    for i = 1:length(rr)
            r = rr(i); s = ss(i);
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
	    	str = [E 0 0; 0 E 0; 0 0 0.5*E]*strain;
	    	stress(nodes(i),1) = (stress(nodes(i),2) * stress(nodes(i),1) + sqrt(((str(1)-str(2))^2 + str(1)^2 + str(2)^2 +6*(str(3)^2))/2))/(stress(nodes(i),2)+1);
	    	stress(nodes(i),2) = stress(nodes(i),2)+1;
		end
    else
        dof = elem(lmn).dof;
        u = un1(dof);

        if size(elem(lmn).ex,1) == 2 && size(elem(lmn).ex,2) == 4
        	% Sum for all sub-elements

        	for k = 1:2
				nodes = dof(8*(k-1)+1:8*k);
		        xvec = elem(lmn).ex(k,:)';	yvec = elem(lmn).ey(k,:)';
			    for i = 1:length(rr)
            		r = rr(i); s = ss(i);
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
				    if(nodes(i) <= nnod)
				    	str = [E 0 0; 0 E 0; 0 0 0.5*E]*strain;
				    	stress(nodes(i),1) = (stress(nodes(i),2) * stress(nodes(i),1) + sqrt(((str(1)-str(2))^2 + str(1)^2 + str(2)^2 +6*(str(3)^2))/2))/(stress(nodes(i),2)+1);
				    	stress(nodes(i),2) = stress(nodes(i),2)+1;
					end
				end
			end
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 3  
        	% Sum for all sub-elements
        	
        	for k = 1:4
		        nodes = dof(6*(k-1)+1:6*k);
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
			 	for i = 1:3
				    if(nodes(i) <= nnod)
				    	str = [E 0 0; 0 E 0; 0 0 0.5*E]*strain;
				    	stress(nodes(i),1) = (stress(nodes(i),2) * stress(nodes(i),1) + sqrt(((str(1)-str(2))^2 + str(1)^2 + str(2)^2 +6*(str(3)^2))/2))/(stress(nodes(i),2)+1);
				    	stress(nodes(i),2) = stress(nodes(i),2)+1;
					end
				end
			end
        elseif size(elem(lmn).ex,1) == 3 && size(elem(lmn).ex,2) == 4  
        	% Sum for all sub-elements
        	for k = 1:3
				nodes = dof(8*(k-1)+1:8*k);
		        xvec = elem(lmn).ex(k,:)';	yvec = elem(lmn).ey(k,:)';
			    for i = 1:length(rr)
            		r = rr(i); s = ss(i);
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
				    if(nodes(i) <= nnod)
				    	str = [E 0 0; 0 E 0; 0 0 0.5*E]*strain;
				    	stress(nodes(i),1) = (stress(nodes(i),2) * stress(nodes(i),1) + sqrt(((str(1)-str(2))^2 + str(1)^2 + str(2)^2 +6*(str(3)^2))/2))/(stress(nodes(i),2)+1);
				    	stress(nodes(i),2) = stress(nodes(i),2)+1;
					end
				end
			end
        elseif size(elem(lmn).ex,1) == 4 && size(elem(lmn).ex,2) == 4  
        	% Sum for all sub-elements
        	for k = 1:4
				nodes = dof(8*(k-1)+1:8*k);
		        xvec = elem(lmn).ex(k,:)';	yvec = elem(lmn).ey(k,:)';
			    for i = 1:length(rr)
            		r = rr(i); s = ss(i);
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
				    if(nodes(i) <= nnod)
				    	str = [E 0 0; 0 E 0; 0 0 0.5*E]*strain;
				    	stress(nodes(i),1) = (stress(nodes(i),2) * stress(nodes(i),1) + sqrt(((str(1)-str(2))^2 + str(1)^2 + str(2)^2 +6*(str(3)^2))/2))/(stress(nodes(i),2)+1);
				    	stress(nodes(i),2) = stress(nodes(i),2)+1;
					end
				end
			end		
        end
    end	
end