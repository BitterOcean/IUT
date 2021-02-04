var float: y1;
var float: y2;
var float: y3;
var float: y4;
var float: y5;
var float: y6;
var float: y7;

constraint (1)*y1 + (0)*y2 +(1)*y3 + (-1)*y4 + (-4)*y5 + (5)*y6 <= y7;
constraint (3)*y1 + (-3)*y2 +(-3)*y3 + (0)*y4 + (4)*y5 + (1)*y6 <= y7;
constraint (-5)*y1 + (1)*y2 +(0)*y3 + (0)*y4 + (5)*y5 + (5)*y6 <= y7;
constraint (1)*y1 + (-5)*y2 +(4)*y3 + (-2)*y4 + (-5)*y5 + (3)*y6 <= y7;
constraint (-5)*y1 + (-5)*y2 +(0)*y3 + (-1)*y4 + (-3)*y5 + (-1)*y6 <= y7;
constraint (-3)*y1 + (3)*y2 +(-2)*y3 + (+3)*y4 + (-3)*y5 + (-4)*y6 <= y7;


constraint y1 + y2 + y3 + y4 + y5 + y6 = 1;
constraint y1 >= 0;
constraint y2 >= 0;
constraint y3 >= 0;
constraint y4 >= 0;
constraint y5 >= 0;
constraint y6 >= 0;

solve minimize y7;