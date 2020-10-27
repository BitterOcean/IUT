"""
Problem : MAX SAT

Description : It is the problem of determining the maximum number of clauses,
              of a given Boolean formula in CNF, that can be made true by an
              assignment of truth values to the variables of the formula.
-------------------------------------------------------------------------------
Algorithm : Random Restart Hill Climbing

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

~$ python3 MaxSAT_RRHC.py INPUT_FILE_ADDRESS

Enjoy it :)
"""
