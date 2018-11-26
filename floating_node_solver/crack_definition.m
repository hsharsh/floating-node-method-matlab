%{
% Rectangle in the middle
if t == 10
	cen = ceil(nelm/2);
	crack = [cen-(ny/2-1):cen+(ny/2-1)];
	for j = 1:length(crack)
		elem(crack(j)).discont = 1;
		elem(crack(j)).edges = [1 -1 1 -1; 0.5 -1 0.5 -1];
	end
end
%}

%{
% Sqauare chunk

if t == 10
	cen = ceil(nelm/2);
	crack1 = cen-(ny/2-1):cen-1;
    crack2 = cen-(ny/2-1)*(ny-1):(ny-1):(cen-ny+1);
    for j = 1:length(crack1)
		elem(crack1(j)).discont = 1;
		elem(crack1(j)).edges = [1 -1 1 -1; 0.5 -1 0.5 -1];
    end
    for j = 1:length(crack2)
		elem(crack2(j)).discont = 1;
		elem(crack2(j)).edges = [-1 1 -1 1; -1 0.5 -1 0.5];
    end        
    elem(cen).discont= 1;
    elem(cen).edges = [1 -1 -1 1; 0.5 -1 -1 0.5];
end
%}

%{
% Radial crack

if t == 10
	cen = ceil(nelm/2);
	crack = [cen-(ny/2-1):cen+(ny/2-1)];
	for j = 1:length(crack)
		elem(crack(j)).discont = 1;
		elem(crack(j)).edges = [1 -1 1 -1; 0.5 -1 0.5 -1];
	end
end
%}

%{
% Rectangle time dependent

cen = ceil(nelm/2);
crack = [cen-(ny/2-1):cen+(ny/2-1)];
tt = 6:1:5+(ny-1);
for j = 1:length(tt)
    if t == tt(j)
		elem(crack(j)).discont = 1;
		elem(crack(j)).edges = [1 -1 1 -1; 0.5 -1 0.5 -1];        
    end
end
%}

stress_elem = zeros(nelm,1);

for lmn = 1:nelm
	% Gauss- Quadrature points and weights
%	xgp = sqrt(3/5)*[-1 0 1];
%   wgp = [5 8 5]/9;
	xgp = [0];
	wgp = [2];
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
	    ar = 0;
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
			    stress = [E 0 0; 0 E 0; 0 0 0.5*E]*strain;
			 	stress_elem(lmn) = stress_elem(lmn) + E*sqrt(((stress(1)-stress(2))^2 + stress(1)^2 + stress(2)^2 +6*(stress(3)^2))/2)*wgp(i)*wgp(j);
			 	ar = ar + wgp(i)*wgp(j);
			end
		end
		stress_elem(lmn) = stress_elem(lmn)/ar;
    end
end

max_stress_element = find(stress_elem == max(stress_elem));

nodes = elem(max_stress_element).nodes;
xvec = x(nodes,1);
yvec = x(nodes,2);        

dof =  [
    nodes(1)*2-1 nodes(1)*2 ...
    nodes(2)*2-1 nodes(2)*2 ...
    nodes(3)*2-1 nodes(3)*2 ...
    nodes(4)*2-1 nodes(4)*2 ...
];

u = un1(dof);

p = [0 0];

stress = compute_stress(p(1),p(2),xvec,yvec,u,E);

sig = [stress(1) 0 0;
		0	stress(2) 0;
		0 0 stress(3)];

[direction, D] = eigs(sig,size(sig,1));

if (D(1) > 2e-1 && elem(max_stress_element).discont == 0)
	dir = [cos(pi/2) -sin(pi/2) 0; sin(pi/2) cos(pi/2) 0; 0 0 1]*direction(1,:)';

	elem(max_stress_element).edges = -1*ones(2,4);
	elem(max_stress_element).discont = 1;

	% Intersection with s = 1
	s = 1; 
	r = dir(1)*(s/dir(2));
	if (-1<r && r<1)
		elem(max_stress_element).edges(:,1) = [1; abs((r-1)/2)]; 
	end

	% Intersection with r = -1
	r = -1; 
	s = dir(2)*(r/dir(1));
	if (-1<s && s<1)
		elem(max_stress_element).edges(:,2) = [1; abs((s-1)/2)]; 
	end
	
	% Intersection with s = -1
	s = -1; 
	r = dir(1)*(s/dir(2));
	if (-1<r && r<1)
		elem(max_stress_element).edges(:,3) = [1; abs((r+1)/2)]; 
	end

	% Intersection with r = 1
	r = 1; 
	s = dir(2)*(r/dir(1));
	if (-1<s && s<1)
		elem(max_stress_element).edges(:,4) = [1; abs((s+1)/2)]; 
	end
	broken = [broken max_stress_element]
end