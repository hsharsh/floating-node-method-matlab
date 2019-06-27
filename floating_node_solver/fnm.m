clc
clear
close all

tic;
% Loading and declaring variables
x = load('nodes.inp');
x = x(:,2:3);
conn = load('elements.inp');
conn = conn(:,2:5);
skip = [];

ny = 20;
%{
nr1 = 6;
nr2 = 12;
ns = 12;
%}
elem = generate_elements(conn);
nnod = size(x,1);
nelm = size(conn,1);
E = 1;
nu = 0;       % Modify code to change from here
rho = 1;
eta = 0; % 0.5*E;

broken = [];
crack = [];
conn_ext = [];
x_ext = [];
%compute_neighbours()

un = zeros(nnod*2,1);	un1 = zeros(nnod*2,1);
vn = zeros(nnod*2,1);	vn1 = zeros(nnod*2,1);
an1 = zeros(nnod*2,1);

M = containers.Map('KeyType','double','ValueType','any');
nodi = nnod*2 + 1;

boundary_conditions()
% general_boundary_conditions()

dt = 0.05;

tmax = 30;
plt_y = 0:dt:tmax;

n = 1;
t = 0;

while t <= tmax

    if ~isempty(broken)
        dt = 0.001;
    end

    mg = zeros((nodi-1),1);
    fi = zeros((nodi-1),1);
    fg = zeros((nodi-1),1);
    lcg = zeros((nodi-1),1);
    % Define crack
    % crack_definition()

	% Add floating nodes to the global matrices
 	% floating_nodes()

	% Linearized Global Stiffness matrix assembly
	assemble_fi()

	% Linearized Global damping matrix
    assemble_cg()

    % Linearized Global Mass matrix assembly
	assemble_mg()

    % For force boundary-conditions
    % general_boundary_conditions()

	% Solver
    fi(1:15)
    mg(1:15)
	an1 = (1./mg).*(fg-fi-lcg);
	vn1 = vn + an1*dt;

    if t <= 4
        boundary_conditions()
    end
    % general_boundary_conditions()

    un1 = un + vn1*dt;

    % Stress + Strain energy
    compute_element_properties()
    compute_nodal_properties()
    plt_y(n) = sum(se);

    % Data extraction
    for i = 1:length(skip)
        s = skip(i);
        un1([s*2-1 s*2],:) = 0;
        vn1([s*2-1 s*2],:) = 0;
        an1([s*2-1 s*2],:) = 0;
        stress(s,:) = 0;
    end



    xdeformed = [x(:,1) + un(1:2:2*nnod) x(:,2) + un(2:2:2*nnod) zeros(size(x(:,1)))];
    u = [un1(1:2:2*nnod) un1(2:2:2*nnod) zeros(size(un1(1:2:2*nnod)))];
    v = [vn1(1:2:2*nnod) vn1(2:2:2*nnod) zeros(size(vn1(1:2:2*nnod)))];
    a = [an1(1:2:2*nnod) vn1(2:2:2*nnod) zeros(size(vn1(1:2:2*nnod,1)))];
    stress = stress(1:nnod,1);

    vtkwrite(['x0',num2str(t*1e5),'.vtk'],conn,xdeformed,u,v,a,stress);

    % Update step
    un = un1;
    vn = vn1;
    n = n+1;
    t = t+dt;
    disp(['t: ',num2str(t),9,9,'   SE: ', num2str(sum(se))]);
end

hold on;

plot(0:dt:tmax,plt_y,'b');
xlabel('Time');
ylabel('Strain energy');
grid on;
toc;