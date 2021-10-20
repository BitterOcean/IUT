"""
Problem : Magic Square
Programming Language : Python3 , OR-Tools

Description : Place 1 to n^2 numbers on a board of size n*n
              so sum of numbers in each row, sum of numbers
              in each column, sum of numbers in south-west
              to north-east diagonal (/) and sum of numbers
              in north-west to south-east diagonal (\)
              becomes a constant value which is n*(n^2 + 1)/2.
              e.g. of a 3*3 magic square :
              4  3  8
              9  5  1
              2  7  6
-------------------------------------------------------------------------------
Input Format : an integer number N

Output Format : the magic square :
                * e.g. for 3*3 magic square :
                s : 15
                4  3  8
                9  5  1
                2  7  6
-------------------------------------------------------------------------------
? How to run it :
~$ python3 Q8_MagicSquare_ORTools.py
-------------------------------------------------------------------------------
Author   : Maryam Saeedmehr
Std. NO. : 9629373

Enjoy it :)
"""
from ortools.constraint_solver import pywrapcp


def main(n=4):
    # Create the solver -----------------------------------------------------------------------
    solver = pywrapcp.Solver('Magic square')

    # Declare variables -----------------------------------------------------------------------
    x = {}
    for i in range(n):
        for j in range(n):
            x[(i, j)] = solver.IntVar(1, n * n, 'x(%i,%i)' % (i, j))
    x_flat = [x[(i, j)] for i in range(n) for j in range(n)]

    # the sum of each row = sum of each column = sum of diagonals / and \ = s -----------------
    s = solver.IntVar(1, n * n * n, 's')

    # Declare Constraints ---------------------------------------------------------------------
    solver.Add(solver.AllDifferent(x_flat, True))
    [solver.Add(solver.Sum([x[(i, j)] for j in range(n)]) == s) for i in range(n)]  # rows
    [solver.Add(solver.Sum([x[(i, j)] for i in range(n)]) == s) for j in range(n)]  # columns
    solver.Add(solver.Sum([x[(i, i)] for i in range(n)]) == s)  # Diagonal /
    solver.Add(solver.Sum([x[(i, n - i - 1)] for i in range(n)]) == s)  # Diagonal \

    # Solution and Search ---------------------------------------------------------------------
    solution = solver.Assignment()
    solution.Add(x_flat)
    solution.Add(s)
    db = solver.Phase(x_flat,
                      solver.CHOOSE_FIRST_UNBOUND,
                      solver.ASSIGN_CENTER_VALUE)
    solver.NewSearch(db)

    # Output ----------------------------------------------------------------------------------
    if solver.NextSolution():
        print("**** Solution Found ****")
        print("s : {}\nMagic Square :".format(s.Value()))
        for i in range(n):
            for j in range(n):
                print("%-7i" % x[(i, j)].Value(), end="")
            print()
        print("**** Solution Found ****")
    else:
        print("Oops! Solution Not Found")
    solver.EndSearch()


if __name__ == '__main__':
    n = int(input("Enter N : "))
    main(n)
