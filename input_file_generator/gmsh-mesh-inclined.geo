// Gmsh project created on Thu Aug 16 13:20:00 2018
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {5, 8.6603, 0, 1.0};
//+
Point(3) = {4.130, 9.1603, 0, 1.0};
//+
Point(4) = {-0.8660, 0.5, 0, 1.0};
//+
Line(1) = {4, 1};
//+
Line(2) = {1, 2};
//+
Line(3) = {2, 3};
//+
Line(4) = {3, 4};
//+
Line Loop(1) = {4, 1, 2, 3};
//+
Plane Surface(1) = {1};
//+
Transfinite Surface {1};
//+
Transfinite Line {4, 2} = 30 Using Progression 1;
//+
Transfinite Line {1, 3} = 6 Using Progression 1;
//+
Recombine Surface {1};
