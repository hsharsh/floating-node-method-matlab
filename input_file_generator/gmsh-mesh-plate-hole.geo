//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0.5, 0, 0, 1.0};
//+
Point(3) = {0.5, 1, 0, 1.0};
//+
Point(4) = {0, 1, 0, 1.0};
//+
Point(5) = {0, 0.5, 0, 1.0};
//+
Point(6) = {0, 0.55, 0, 1.0};
//+
Point(7) = {0, 0.45, 0, 1.0};
//+
Point(8) = {0.0353, 0.5353, 0, 1.0};
//+
Point(9) = {0.0353, 0.4646, 0, 1.0};
//+
Circle(1) = {6, 5, 8};
//+
Circle(2) = {9, 5, 8};
//+
Circle(3) = {7, 5, 9};
//+
Line(4) = {6, 4};
//+
Line(5) = {4, 3};
//+
Line(6) = {3, 2};
//+
Line(7) = {2, 1};
//+
Line(8) = {1, 7};
//+
Line(9) = {8, 3};
//+
Line(10) = {9, 2};
//+
Line Loop(1) = {1, 9, -5, -4};
//+
Plane Surface(1) = {1};
//+
Line Loop(2) = {-9, -2, 10, -6};
//+
Plane Surface(2) = {2};
//+
Line Loop(3) = {-10, -3, -8, -7};
//+
Plane Surface(3) = {3};

//+
Transfinite Line {8, 10, 9, 4} = 12 Using Progression 1;
//+
Transfinite Line {7, 3} = 6 Using Progression 1;
//+
Transfinite Line {2, 6} = 12 Using Progression 1;
//+
Transfinite Line {1, 5} = 6 Using Progression 1;
//+
Transfinite Surface {3} = {2, 1, 7, 9};
//+
Transfinite Surface {2} = {3, 2, 9, 8};
//+
Transfinite Surface {1} = {4, 3, 8, 6};
//+
Recombine Surface {3};
//+
Recombine Surface {2};
//+
Recombine Surface {1};
