"""
Problem : 0/1 Knapsack

Description : It is a problem in combinatorial optimization. Given a set of
              items, each with a weight and a value, determine the number of
              each item to include in a collection so that the total weight
              is less than or equal to a given limit and the total value is
              as large as possible.
-------------------------------------------------------------------------------
Algorithm : Simulated Annealing

Input Format : The first input line contains two numbers that specifies the
               number of items and the whole weight of knapsack, respectively.
               The next lines (to the number of items) each has two number
               specifies item's value and wight.

Output Format : In the first line, print two natural numbers that represents
                the sum of values of items and the sum of their weights. In
                the next lines(to the number of items) in each line print one
                of 0 or 1 that indicates that item is taken or not.
-------------------------------------------------------------------------------
? How to run it :

~$ python3 Knapsack_SA.py INPUT_FILE_ADDRESS

Enjoy it :)
"""
# import random
# import sys
#
# # Global variables
# Infinity = sys.maxsize
# Temperature = Infinity
#
#
# # This function will decrease temperature
# def Schedule(time):
#     pass
#
#
# def Make_Node():
#     return 0
#
#
# def Simulated_Annealing(problem, schedule):
#     Current_State = Make_Node()
#     for time in range(1, Infinity):
#         Schedule(time)
#         if Temperature == 0:
#             return Current_State
#         #Next_State = ?


import time
import random
import math
import numpy as np
import matplotlib.pyplot as plt

# ------------------------------------------------------------------------------
# Customization section:
initial_temperature = 100
cooling = 0.8  # cooling coefficient
number_variables = 2
upper_bounds = [3, 3]
lower_bounds = [-3, -3]
computing_time = 1  # second(s)


def objective_function(X):
    x = X[0]
    y = X[1]
    value = 3 * (1 - x) ** 2 * math.exp(-x ** 2 - (y + 1) ** 2) - 10 * (x / 5 - x ** 3 - y ** 5) * math.exp(
        -x ** 2 - y ** 2) - 1 / 3 * math.exp(-(x + 1) ** 2 - y ** 2)
    return value


# ------------------------------------------------------------------------------
# Simulated Annealing Algorithm:
initial_solution = np.zeros(number_variables)
for v in range(number_variables):
    initial_solution[v] = random.uniform(lower_bounds[v], upper_bounds[v])

current_solution = initial_solution
best_solution = initial_solution
n = 1  # no of solutions accepted
best_fitness = objective_function(best_solution)
current_temperature = initial_temperature  # current temperature
start = time.time()
no_attempts = 100  # number of attempts in each level of temperature
record_best_fitness = []

for i in range(9999999):
    for j in range(no_attempts):

        for k in range(number_variables):
            current_solution[k] = best_solution[k] + 0.1 * (random.uniform(lower_bounds[k], upper_bounds[k]))
            current_solution[k] = max(min(current_solution[k], upper_bounds[k]),
                                      lower_bounds[k])  # repair the solution respecting the bounds

        current_fitness = objective_function(current_solution)
        E = abs(current_fitness - best_fitness)
        if i == 0 and j == 0:
            EA = E

        if current_fitness < best_fitness:
            p = math.exp(-E / (EA * current_temperature))
            # make a decision to accept the worse solution or not
            if random.random() < p:
                accept = True  # this worse solution is accepted
            else:
                accept = False  # this worse solution is not accepted
        else:
            accept = True  # accept better solution
        if accept:
            best_solution = current_solution  # update the best solution
            best_fitness = objective_function(best_solution)
            n = n + 1  # count the solutions accepted
            EA = (EA * (n - 1) + E) / n  # update EA

    print('interation: {}, best_solution: {}, best_fitness: {}'.format(i, best_solution, best_fitness))
    record_best_fitness.append(best_fitness)
    # Cooling the temperature
    current_temperature = current_temperature * cooling
    # Stop by computing time
    end = time.time()
    if end - start >= computing_time:
        break
plt.plot(record_best_fitness)
