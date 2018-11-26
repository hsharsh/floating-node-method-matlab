//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {5, 0, 0, 1.0};
//+
Point(3) = {15, 0, 0, 1.0};
//+
Point(4) = {0, 5, 0, 1.0};
//+
Point(5) = {0, 15, 0, 1.0};
//+
Circle(1) = {3, 1, 5};
//+
Circle(2) = {2, 1, 4};
//+
Line(3) = {5, 4};
//+
Line(4) = {2, 3};
//+
Line Loop(1) = {-2, 4, 1, 3};
//+
Plane Surface(1) = {1};
//+
Transfinite Line {3, 4} = 16 Using Progression 1;
//+
Transfinite Line {2, 1} = 16 Using Progression 1;
//+
Transfinite Surface {1} = {2, 3, 5, 4};
//+
Recombine Surface {1};
//+

