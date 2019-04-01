%{
% Radial solid wave

left = [4 5 (2*ny+2:3*ny-1)];
bc1 = 0;
for ibc = 1:length(left)
   node_bc = left(ibc);
   idof = node_bc*2-1;
   vn(idof) = bc1;
   vn1(idof) = bc1;
end

bottom = [2 3 (3*ny:4*ny-3)];
bc2 = 0;
for ibc = 1:length(bottom)
   node_bc = bottom(ibc);
   idof = node_bc*2-1;
   vn(idof+1) = bc2;
   vn1(idof+1) = bc2;
end
%}


% Rectangle time dependent

left = [1 4 5:ny+2];
bc1 = -0.05;
for ibc = 1:length(left)
    node_bc = left(ibc);
    idof = node_bc*2-1;
    vn(idof) = bc1;
    vn1(idof) = bc1;
end


right = [2 3 2*ny+1:3*ny-2];
bc1 = 0.05;
for ibc = 1:length(right)
    node_bc = right(ibc);
    idof = node_bc*2-1;
    vn(idof) = bc1;
    vn1(idof) = bc1;
end



%{
% Plate with a hole

left = [3,   4,   7,   8,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46, 47,  48,  49,  50,  51,  52,  53, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133];
% left = [1 (4*nr1+2*nr2+ns-4):(4*nr1+2*nr2+2*ns-7) 7  4 (4+2*nr1+nr2):(1+2*nr1+nr2+ns) 6];

bc1 = 0;
for ibc = 1:length(left)
    node_bc = left(ibc);
    idof = node_bc*2-1;
    vn(idof) = bc1;
    vn1(idof) = bc1;
end

top =   [5, 7, 108, 109, 110, 111, 112, 113, 114];
% top = [3 4 (2+2*nr1+nr2+ns):(3*nr1+nr2+ns-1)];

bc2 = 0.01;
for ibc = 1:length(top)
    node_bc = top(ibc);
    idof = node_bc*2-1;
    vn(idof+1) = bc2;
    vn1(idof+1) = bc2;
end


% bottom =[1,  4, 54, 55, 56, 57, 58, 59, 60];
% bottom = [1 2 (3*nr1+2*nr2+ns-2):(4*nr1+2*nr2+ns-5)];
bc2 = -0.01;
for ibc = 1:length(bottom)
    node_bc = bottom(ibc);
    idof = node_bc*2-1;
    vn(idof+1) = bc2;
    vn1(idof+1) = bc2;
end

%{
% Abaqus mesh boundaries (mine)
left = [3,   4,   7,   8,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46, 47,  48,  49,  50,  51,  52,  53, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133];
top =   [5,   7, 108, 109, 110, 111, 112, 113, 114];
bottom =[1,  4, 54, 55, 56, 57, 58, 59, 60];

%}


%{
% Abaqus mesh boundaries

left = [  3,  4,  7,  8, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91];
top =   [2,  3, 28, 29, 30, 31, 32, 33, 34, 35, 36];
bottom =[   5,   8,  92,  93,  94,  95,  96,  97,  98,  99, 100];

%}
%}

%{
% Plate with two holes
left = [3,   4,  11,  12,  31,  32,  33,  34,  35,  36,  37,  38,  39, 111, 112, 113, 114, 115, 116, 117, 118, 119, 140, 141, 142, 143];
bc1 = 0;
for ibc = 1:length(left)
    node_bc = left(ibc);
    idof = node_bc*2-1;
    un(idof) = bc1;
    un1(idof) = bc1;
end

top =  [ 9,  10,  11, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110];
bc2 = 0.01;
for ibc = 1:length(top)
    node_bc = top(ibc);
    idof = node_bc*2-1;
    vn(idof+1) = bc2;
    vn1(idof+1) = bc2;
end


bottom = [  1,  4,  6, 40, 41, 42, 43, 51, 52, 53, 54, 55, 56, 57];
bc2 = -0.01;
for ibc = 1:length(bottom)
    node_bc = bottom(ibc);
    idof = node_bc*2-1;
    vn(idof+1) = bc2;
    vn1(idof+1) = bc2;
end
%}

%{
% Uniform loading

left = [1:42:169];
bc1 = -0.01;
for ibc = 1:length(left)
    node_bc = left(ibc);
    idof = node_bc*2-1;
    % vn(idof) = bc1;
    % vn1(idof) = bc1;
    fg(idof) = bc1;
end


right = [42:42:210];
bc1 = 0.01;
for ibc = 1:length(right)
    node_bc = right(ibc);
    idof = node_bc*2-1;
    % vn(idof) = bc1;
    % vn1(idof) = bc1;
    fg(idof) = bc1;
end
%}