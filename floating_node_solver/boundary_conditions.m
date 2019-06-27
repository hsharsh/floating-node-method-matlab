
% Rectangle
%{
left = [1 4 5:ny+2];
bc1 = 0.1;
bc2 = 0;
for ibc = 1:length(left)
   node_bc = left(ibc);
   idof = node_bc*2-1;
   vn(idof) = bc1;
   vn1(idof) = bc1;
   vn(idof+1) = bc2;
   vn1(idof+1) = bc2;
end
%}

%{
% Inclined Rectangle

left = [1 4 5:ny+2];
bc1 = 0.05;
bc2 = 0.086603;
for ibc = 1:length(left)
   node_bc = left(ibc);
   idof = node_bc*2-1;
   vn(idof) = bc1;
   vn1(idof) = bc1;
   vn(idof+1) = bc2;
   vn1(idof+1) = bc2;
end
%}

%{
% Square chunk

left = [1 4 5:ny+2];
bc1 = 0.1;
for ibc = 1:length(left)
   node_bc = left(ibc);
   idof = node_bc*2-1;
   vn(idof) = bc1;
   vn1(idof) = bc1;
end


bottom = [1 2 (ny+3):(2*ny)];
bc2 = 0.1;
for ibc = 1:length(bottom)
   node_bc = bottom(ibc);
   idof = node_bc*2-1;
   vn(idof+1) = bc2;
   vn1(idof+1) = bc2;
end
%}

%{
% Radial solid wave
inner = [2 ny+4:2*ny+1 4];

for ibc = 1:length(inner)
   node_bc = inner(ibc);
   idof = node_bc*2-1;
   bc1 = x(node_bc,1); bc2 = x(node_bc,2);   r = sqrt(bc1^2+bc2^2);
   bc1 = 0.1*bc1/r; bc2 = 0.1*bc2/r;
   vn(idof) = bc1;
   vn1(idof) = bc1;
   vn(idof+1) = bc2;
   vn1(idof+1) = bc2;
end
%}

% Simple square plate
left = [1:21:421];
bc1 = 0.01;
for ibc = 1:length(left)
    node_bc = left(ibc);
    idof = node_bc*2-1;
    vn(idof) = bc1;
    vn1(idof) = bc1;
    % fg(idof) = bc1;
end
