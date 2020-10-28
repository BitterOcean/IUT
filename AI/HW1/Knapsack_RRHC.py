"""
Problem : 0/1 Knapsack
Programming Language : Python3

Description : It is a problem in combinatorial optimization. Given a set of
              items, each with a weight and a value, determine the number of
              each item to include in a collection so that the total weight
              is less than or equal to a given limit and the total value is
              as large as possible.
-------------------------------------------------------------------------------
Algorithm : Random Restart Hill Climbing

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
~$ python3 Knapsack_RRHC.py TestBench_File_Name_Or_Address

* Example :
    ~$ python3 Knapsack_RRHC.py knapsack-20.txt
    ~$ python3 Knapsack_RRHC.py knapsack-100.txt
    ~$ python3 Knapsack_RRHC.py ./samples/knapsack-samples/knapsack-20.txt
    ~$ python3 Knapsack_RRHC.py ./samples/knapsack-samples/knapsack-100.txt
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
    class Item:
        def __init__(self, V, W):
            self.Value = V
            self.Weight = W

    def __init__(self):
        self.Knapsack_Weight = 0
        self.Number_Of_Items = 0
        self.Item_List = []
        self.Selected_Items = []
        self.Selected_Items_Weight = 0
        self.Selected_Items_Value = 0

    def Create(self, N, W, item):
        self.Knapsack_Weight = W
        self.Number_Of_Items = N
        self.Item_List = [self.Item(item[i][0], item[i][1]) for i in range(N)]

    def Set_Value(self, selected_item, weight, value):
        """
        Used to store the values of current state
        """
        self.Selected_Items = selected_item
        self.Selected_Items_Value = value
        self.Selected_Items_Weight = weight


# Global Variables
problem = Problem()


def Random_Restart_Hill_Climbing():
    pass


def Read_File(file_name):
    """
    It sets up the problem in this way :
    problem.Item_List is like [[item_n_val, item_n_wight], ..., [item_x_val, item_x_weight]].
    It also sets problem.Number_of_Items and problem.Knapsack_Weight.
    """
    try:
        global problem
        File_Item_List = list()
        with open(file_name, "r") as infile:
            [Number_of_Items, Knapsack_Weight] = infile.readline().split(' ')
            for i in infile:
                file_item = list()
                for j in i.split(' '):
                    file_item.append(int(j.replace('\n', '')))
                File_Item_List.append(file_item)
        problem.Create(int(Number_of_Items), int(Knapsack_Weight), File_Item_List)
    except FileNotFoundError:
        print("Wrong file or file path")
        sys.exit()


if __name__ == "__main__":
    File_name = input("File name/address : ")
    Read_File(File_name)
    start_time = time.time()
    Random_Restart_Hill_Climbing()
    end_time = time.time()
    runtime_duration = end_time - start_time
    print("Maximum Value : {}, Maximum Weight : {}".format(problem.Selected_Items_Value, problem.Selected_Items_Weight))
    for item in problem.Selected_Items:
        print(item)
    print('Runtime Duration : {} s'.format(runtime_duration))
