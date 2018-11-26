rr = -1:0.1:1;
ss = -1:0.1:1;

X = zeros(length(rr),length(ss));
Y = zeros(length(rr),length(ss));
sigma = zeros(length(rr),length(ss));

nodes = conn(max_stress_element,:);
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
	for j = 1:length(ss)
		r = rr(i);	s = ss(j);
		X(i,j) = rr(i);
		Y(i,j) = ss(j);
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
	    sigma(i,j) = E*strain(2);
	    %E*sqrt(((strain(1)-strain(2))^2 + strain(1)^2 + strain(2)^2 +6*(strain(3)^2))/2);
	end
end

surf(X,Y,sigma);
xlabel('r');
ylabel('s');
zlabel('stress');
axis equal;
