% Class Scheduling CSP %
% Define Variables and Domains :
% 1->A , 2->B, 3->C
var 3..3: Class1;
var 2..3: Class2;
var 1..3: Class3;
var 1..3: Class4;
var 2..3: Class5;

% Define Constraints :
constraint Class1 != Class2;
constraint Class2 != Class3;
constraint Class2 != Class4;
constraint Class3 != Class4;
constraint Class3 != Class5;
constraint Class4 != Class5;

% Solve It !
solve satisfy;

% Print the results :
output ["Class1 = \(Class1)\n",
        "Class2 = \(Class2)\n",
        "Class3 = \(Class3)\n",
        "Class4 = \(Class4)\n",
        "Class5 = \(Class5)\n"]
