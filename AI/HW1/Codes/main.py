"""
 # Problem Declaration :
     Three missionaries and three cannibals are on one side of a river,
     along with a boat that can hold one or two people.
     Find a way to get everyone to the other side without ever leaving a group
     of missionaries in one place outnumbered by the cannibals in that place.

 # Works Done :
    * Problem formulation
      (so it can be solved by searching)
    * Computer implementation in order to experimentally compare the
      performance of the BFS and the DFS search strategy.

 # For performance comparison‌ I use :
    * Time
    * Number of nodes explored
    * Number of nodes expanded
    * Effective branching factor

 # Extra Options :
    * This implementation is able to deal with a scaled-up version of this problem
     (for example, a problem with five missionaries and five cannibals).

 # The implementation has :
    * m number of missionaries,
    * c number of cannibals,
    * k number of maximum allowable passengers in the boat.
    * Search cut-off limit :
        ** Time Limit
        ** Node Limit
           (for example termination :
            after 30 seconds,or
            after 1,000,000 nodes have been expanded)

 # Author :
    * Maryam Saeedmehr
    * SN : 9629373

"""

import sys
import time
from Graph import Graph
from State import State, Direction, TERMINAL_STATE
from Constants import CONST

CON_IN = sys.stdin
CON_OUT = sys.stdout

# Generate All possible next moves for each state to reduce number of iterations on each node
def genPossibleMoves(CAP_BOAT):
	moves = []
	for m in range(CAP_BOAT + 1):
		for c in range(CAP_BOAT + 1):
			if 0 < m < c:
				continue
			if 1 <= m + c <= CAP_BOAT:
				moves.append((m, c))
	return moves


def runBFS(g, INITIAL_STATE):
	sys.stdout = open("outBFS.txt", "w")
	print("\n\nBFS :: \n")
	start_time = time.time()
	p = g.BFS(INITIAL_STATE)
	end_time = time.time()
	if len(p):
		g.printPath(p, TERMINAL_STATE)
	else:
		print("No Solution")
	print("\n Elapsed time in BFS: %.2fms" % ((end_time - start_time)*1000))


def runDFS(g, INITIAL_STATE):
	sys.stdout = open("outDFS.txt", "w")
	print("\n\nDFS :: \n")
	start_time = time.time()
	p = g.DFS(INITIAL_STATE)
	end_time = time.time()
	if len(p):
		g.printPath(p, TERMINAL_STATE)
	else:
		print("No Solution")
	print("\n Elapsed time in DFS: %.2fms" % ((end_time - start_time)*1000))


def main():
	sys.stdin = open("input.txt", "r")

	m = int(input("Missionaries="))
	print(m, end="\n")
	c = int(input("Cannibals="))
	print(c, end="\n")
	k = int(input("Maximum allowable passengers in the boat="))
	print(k, end="\n")
	t = int(input("TIME_LIMIT_s="))
	print(t, end="\n")
	n = int(input("NODE_LIMIT="))
	print(n, end="\n")

	CNST = CONST(m, c, k, t, n)

	moves = genPossibleMoves(CNST.CAP_BOAT)
	print(str(moves.__len__())+" iterations per Node.")

	INITIAL_STATE = State(CNST.MAX_M, CNST.MAX_C, Direction.OLD_TO_NEW, 0, 0, 0, CNST, moves)
	# TERMINAL_STATE = State(-1, -1, Direction.NEW_TO_OLD, -1, -1, 0)

	g = Graph()
	sys.stdout = CON_OUT
	print("\nRunning BFS...")
	runBFS(g, INITIAL_STATE)
	sys.stdout = CON_OUT
	print("Executed BFS...")

	print("\nRunning DFS...")
	runDFS(g, INITIAL_STATE)
	sys.stdout = CON_OUT
	print("Executed DFS...")


if __name__ == '__main__':
	main()
