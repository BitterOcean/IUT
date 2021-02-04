var float: x1;
var float: x2;
var float: x3;
var float: x4;
var float: x5;
var float: x6;
var float: x7;
var float: x8;

constraint (1)*x1 + (3)*x2 +(-5)*x3 + (1)*x4 + (-5)*x5 + (3)*x6 + (-3)*x7 >= x8;
constraint (0)*x1 + (-3)*x2 +(1)*x3 + (-5)*x4 + (-5)*x5 + (-1)*x6 + (3)*x7 >= x8;
constraint (1)*x1 + (-3)*x2 +(0)*x3 + (4)*x4 + (0)*x5 + (-3)*x6 + (-2)*x7 >= x8;
constraint (-1)*x1 + (0)*x2 +(0)*x3 + (-2)*x4 + (-1)*x5 + (2)*x6 + (3)*x7 >= x8;
constraint (-4)*x1 + (4)*x2 +(5)*x3 + (-5)*x4 + (3)*x5 + (-3)*x6 + (-3)*x7 >= x8;
constraint (5)*x1 + (1)*x2 +(5)*x3 + (3)*x4 + (-4)*x5 + (-1)*x6 + (-4)*x7 >= x8;
constraint x1 + x2 + x3 + x4 + x5 + x6 + x7 = 1;
constraint x1>= 0;
constraint x2>= 0;
constraint x3>= 0;
constraint x4>= 0;
constraint x5>= 0;
constraint x6>= 0;
constraint x7>= 0;

solve maximize x8;