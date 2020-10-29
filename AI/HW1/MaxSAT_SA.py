"""
Problem : MAX SAT
Programming Language : Python3

Description : It is the problem of determining the maximum number of clauses,
              of a given Boolean formula in CNF, that can be made true by an
              assignment of truth values to the variables of the formula.
-------------------------------------------------------------------------------
Algorithm : Simulated Annealing

Input Format : The first input line contains two numbers that specifies the
               number of variables and the number of clauses, respectively.
               The next lines (to the number of clauses) each specify the
               number of variables present in the corresponding clause. The
               negative sign indicates the notation of NOT. Each line ends
               with 0. Finally, Variables are named from 1

Output Format : In the first line, print a natural number that represents the
                maximum number of clauses that are true. In the next lines
                (to the number of variables) in each line print one of 0 or 1
                that indicates the value of that variable.
-------------------------------------------------------------------------------
? How to run it :
~$ python3 MaxSAT_SA.py
-------------------------------------------------------------------------------
Author : Maryam Saeedmehr
Std NO : 9629373

Enjoy it :)
"""
import sys
import time
import math
import random


class Problem:
    class Clause:
        def __init__(self, var):
            self.Variable = var  # an array of variables' name used in this clause

    def __init__(self):
        self.Number_Of_Variables = None
        self.Number_Of_Clauses = None
        self.Variable_List = []
        self.Clause_List = []  # array of Clause Objects.
        self.Number_Of_Satisfied_Clauses = 0

    def Create(self, V, C, clause):
        self.Number_Of_Variables = V
        self.Number_Of_Clauses = C
        self.Clause_List = [self.Clause(clause[i]) for i in range(C)]

    def Set_Values(self, variable_list, number_of_satisfied_clauses):
        """
        Used to store the values of current state
        """
        self.Variable_List = variable_list
        self.Number_Of_Satisfied_Clauses = number_of_satisfied_clauses


# Global Variables
Infinity = sys.maxsize
Temperature = 100
Cooling_Rate = 0.999
# -----------------------------------
"""
These variables used to evaluate 
next states in order to decide 
whether that state is better 
or not !
"""
clause_list = []
number_of_satisfied_clauses = 0
# -----------------------------------
problem = Problem()


def Reset_Clause_List():
    global clause_list, problem
    clause_list = [0 for i in range(problem.Number_Of_Clauses)]


def Geometric_Cooling():
    """
    A Scheduler to decrease temperature by
    creating a geometric sequence with the
    common ratio that is Cooling_Rate here
    """
    global Temperature
    Temperature = Temperature * Cooling_Rate


def Evaluate(next_state):
    """
    next state is an array that specifies the value of each variable
    this function will return the number of satisfied clauses for next
    state parameter.
    """
    global problem, number_of_satisfied_clauses, clause_list
    number_of_satisfied_clauses = 0
    Reset_Clause_List()
    for c in range(problem.Number_Of_Clauses):
        for v in problem.Clause_List[c].Variable:
            if int(v) < 0:
                clause_list[c] = clause_list[c] | int(not (next_state[abs(int(v)) - 1]))
                if clause_list[c]:
                    number_of_satisfied_clauses = number_of_satisfied_clauses + 1
                    break
            else:
                clause_list[c] = clause_list[c] | next_state[abs(int(v)) - 1]
                if clause_list[c]:
                    number_of_satisfied_clauses = number_of_satisfied_clauses + 1
                    break
    return number_of_satisfied_clauses


def Simulated_Annealing():
    """
    S_Metaheuristic algorithm to solve MAX-SAT which is an NP-Complete Problem.
    """
    global problem, clause_list, number_of_satisfied_clauses
    Current_State = [random.randint(0, 1) for i in range(problem.Number_Of_Variables)]
    for t in range(Infinity):
        if math.floor(Temperature) == 0.0:
            return Current_State
        Next_State = [random.randint(0, 1) for i in range(problem.Number_Of_Variables)]
        delta_E = Evaluate(Next_State) - problem.Number_Of_Satisfied_Clauses
        if delta_E > 0:
            Current_State = Next_State
            problem.Set_Values(Next_State, number_of_satisfied_clauses)
        else:
            probability = math.exp(delta_E / Temperature)
            if random.random() < probability:
                Current_State = Next_State
                problem.Set_Values(Next_State, number_of_satisfied_clauses)
        Geometric_Cooling()


def Read_File(file_name):
    """
    It sets up the problem in this way :
    problem.Clause_List is like [[var_n, ..., var_m], ..., [var_x, ..., var_y]].
    It also sets problem.Number_of_Clauses and problem.Number_of_Variables.
    """
    try:
        global problem, clause_list
        File_Clause_List = list()
        with open(file_name, "r") as infile:
            [Number_of_Variables, Number_of_Clauses] = infile.readline().split('  ')
            for i in infile:
                file_clause = list()
                for j in i.split(' '):
                    if j != '0\n':
                        file_clause.append(j)
                File_Clause_List.append(file_clause)
        problem.Create(int(Number_of_Variables), int(Number_of_Clauses), File_Clause_List)
    except FileNotFoundError:
        print("Wrong file or file path")
        sys.exit()


if __name__ == "__main__":
    File_name = input("File name/address : ")
    Read_File(File_name)
    start_time = time.time()
    Simulated_Annealing()
    end_time = time.time()
    runtime_duration = end_time - start_time
    print("Number of Maximum Satisfied Clauses : {} out of {}".format(problem.Number_Of_Satisfied_Clauses, problem.Number_Of_Clauses))
    for var in problem.Variable_List:
        print(var)
    print('Runtime Duration : {} s'.format(runtime_duration))
