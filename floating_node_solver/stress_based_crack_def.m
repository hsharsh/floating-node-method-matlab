for lmn = 1:nelm
	if(elem(lmn).discont == 2)
		continue;
	end
	nodes = elem(lmn).nodes;
	xvec = x(nodes,1);
	yvec = x(nodes,2);        

	dof =  [
	    nodes(1)*2-1 nodes(1)*2 ...
	    nodes(2)*2-1 nodes(2)*2 ...
	    nodes(3)*2-1 nodes(3)*2 ...
	    nodes(4)*2-1 nodes(4)*2 ...
	];

	u = un(dof);
	rr = [-99 -1 -99 1];
	ss = [1  -99 -1 -99];

	edge_var = zeros(4,3);
	for i = 1:4
	    r = rr(i); s = ss(i);
    	tol = 1e-5;
	    if r == -99
	    	% Ternary search over s for stress maxima. Assuming stress to be unimodal on domain [-1,1]

	    	left = -1; right = 1;
	    	for run = 1:50
	    		if (abs(right-left) < tol)
	    			r = (right+left)/2;
	    			break;
	    		end
	    		lthird = left + (right-left)/3;
	    		rthird = right - (right-left)/3;
	    		if compute_stress(lthird,s,xvec,yvec,u,E) > compute_stress(rthird,s,xvec,yvec,u,E)
	    			right = rthird;
	    		else
	    		 	left = lthird;
	    		end 
			end
		else
	    	% Ternary search over s for stress maxima. Assuming stress to be unimodal on domain [-1,1]

	    	left = -1; right = 1;
	    	for run = 1:50
	    		if (abs(right-left) < tol)
	    			s = (right+left)/2;
	    			break;
	    		end
	    		%disp(left);
	    		%disp(right);
	    		lthird = left + (right-left)/3;
	    		rthird = right - (right-left)/3;
	    		if compute_stress(r,lthird,xvec,yvec,u,E) > compute_stress(r,rthird,xvec,yvec,u,E)
	    			right = rthird;
	    		else
	    		 	left = lthird;
	    		end 
			end			
		end
		edge_var(i,1) = compute_stress(r,s,xvec,yvec,u,E);
		edge_var(i,2) = r;	
		edge_var(i,3) = s;
	end
	
	[max1, i1] = max(edge_var(:,1));
	if max1 >= 1.8e-1
		[max2, i2] = max(edge_var(find( edge_var(:,1) < max(edge_var(:,1))),1));
		m1 = edge_var(i1,:);
		if(i2 >= i1)
			m2 = edge_var(i2+1,:);
		else
			m2 = edge_var(i2,:);
		end

		elem(lmn).edges = -1*ones(2,4);
		elem(lmn).discont = 1;
		
		if m1(3) == 1
			elem(lmn).edges(:,1) = [1; (1 - m1(2))/2];
 
        elseif m1(2) == -1
			elem(lmn).edges(:,2) = [1; (1 - m1(3))/2];
        elseif m1(3) == -1
			elem(lmn).edges(:,3) = [1; (m1(2) + 1)/2];
		else
			elem(lmn).edges(:,4) = [1; (m1(3) + 1)/2];
		end

		if m2(3) == 1
			elem(lmn).edges(:,1) = [1; (1 - m2(2))/2]; 
        elseif m2(2) == -1
			elem(lmn).edges(:,2) = [1; (1 - m2(3))/2];
        elseif m2(3) == -1
			elem(lmn).edges(:,3) = [1; (m2(2) + 1)/2];
		else
			elem(lmn).edges(:,4) = [1; (m2(3) + 1)/2];
		end
		broken = [broken lmn];
		fprintf('%f\n',t)
		lmn
		edge_var
		elem(lmn).edges	
	end
end