"""
Problem : Shortest path in a 2D grid
Programming Language : Python3

Description :
It’node the year 3002. The robots of “ROBOTS’R US (R:US)” have taken control over the world. You
are one of the few people who remain alive only to act as their guinea pigs. From time to time the
robots use you to find if they have been able to become more intelligent. You, being the smart guy,
have always been successful in proving to be more intelligent.
Today is your big day. If you can beat the fastest robot in the IRQ2003 land, you’d be free.
These robots are intelligent. However, they have not been able to overcome a major deficiency in their
physical design — they can only move in 4 directions: Forward, Backward, Upward and Downward.
And they take 1 unit time to travel 1 unit distance. As you have got only one chance, you’re planning it
thoroughly. The robots have left one of the fastest robot to guard you. You’d need to program another
robot which would carry you through the rugged terrain. A crucial part of your plan requires you to
find the how much time the guard robot would need to reach your destination. If you can beat him,
you’re through.
We must warn you that the IRQ2003 land is not a pleasant place to roam. The R:US have dropped
numerous bombs while they invaded the human land. Most of the bombs have exploded. Still some of
the bombs remain acting as land mines. We have managed to get a map that shows the unsafe regions
of the IRQ2003 land; unfortunately your guard has a copy of the map, too. We know that at most
40% of the area can be unsafe. If you are to beat your guard, you’d have to find his fastest route long
before he finds it.
-------------------------------------------------------------------------------
Input Format :
Input consists of several test cases. Each test begins with two integers R (1 ≤ R ≤ 1000),
C (1 ≤ C ≤ 1000) — they give you the total number of rows and columns in the grid map of the land. Then
follows the grid locations of the bombs. It starts with the number of rows, (0 ≤ rows ≤ R) containing bombs.
For each of the rows, you’d have one line of input. These lines start with the row number, followed
by the number of bombs in that row. Then you’d have the column locations of that many bombs in
that row. The test case ends with the starting location (row, column) followed by your destination
(row, column). All the points in the region is in the range (0, 0) to (R − 1, C − 1). Input ends with a
test case where R = 0 and C = 0, you must not process this test case.

Output Format :
For each test case, print the time the guard robot would take to go from the starting location to
the destination.
-------------------------------------------------------------------------------
Sample Input
10 10
9
0 1 2
1 1 2
2 2 2 9
3 2 1 7
5 3 3 6 9
6 4 0 1 2 7
7 3 0 3 8
8 2 7 9
9 3 2 3 4
0 0
9 9
0 0

Sample Output
18
-------------------------------------------------------------------------------
? How to run it :
~$ python3 13.py
-------------------------------------------------------------------------------
Author   : Maryam Saeedmehr
Std. NO. : 9629373

Enjoy it :)
"""


class Problem:
    class Node:
        """
        Used in Frontier queue
        """

        def __init__(self, row, col, cost):
            self.row = row
            self.col = col
            self.cost = cost

    def __init__(self, row, col, bombs):
        """
         0 -> free cell
        -1 -> bomb
         1 -> source
         2 -> destination
        """
        self.row = row
        self.col = col
        self.bombs = bombs
        self.source = (-1, -1)
        self.destination = (-1, -1)
        self.BombList = []  # used in "explored" list to make bomb cells visited easily
        self.grid = [[0] * self.row for _ in range(self.col)]

    def addBombs(self, x, y):
        self.BombList.append((x, y))
        self.grid[x][y] = -1

    def addSource(self, x, y):
        self.source = (x, y)
        self.grid[x][y] = 1

    def addDestination(self, x, y):
        self.destination = (x, y)
        self.grid[x][y] = 2

    def goalTest(self, x, y):
        if (x, y) == self.destination:
            return True
        return False

    def BFS(self):
        """
        Graph Search version
        """
        explored = [[False] * self.row for _ in range(self.col)]
        frontier = []  # FIFO Queue
        for i in range(len(self.BombList)):
            explored[self.BombList[i][0]][self.BombList[i][1]] = True
        frontier.append(self.Node(self.source[0], self.source[1], 0))
        explored[self.source[0]][self.source[1]] = True

        while frontier:
            node = frontier.pop(0)
            explored[node.row][node.col] = True
            if self.goalTest(node.row, node.col):
                # Late Goal Test
                return node.cost

            # Up ------------------------------------------------------------
            if node.row - 1 >= 0 and \
                    not explored[node.row - 1][node.col]:
                frontier.append(self.Node(node.row - 1, node.col, node.cost + 1))

            # Down ----------------------------------------------------------
            if node.row + 1 < self.col and \
                    not explored[node.row + 1][node.col]:
                frontier.append(self.Node(node.row + 1, node.col, node.cost + 1))

            # Left -----------------------------------------------------------
            if node.col - 1 >= 0 and \
                    not explored[node.row][node.col - 1]:
                frontier.append(self.Node(node.row, node.col - 1, node.cost + 1))

            # Right ----------------------------------------------------------
            if node.col + 1 < self.row and \
                    not explored[node.row][node.col + 1]:
                frontier.append(self.Node(node.row, node.col + 1, node.cost + 1))

        return -1


def main():
    # Read Data ----------------------------------------------------------------------------------------------
    [row, col] = [int(n) for n in input().split()]
    while row or col:
        bombs = int(input())
        problem = Problem(row, col, bombs)
        for i in range(bombs):
            BombData = [int(i) for i in input().split()]  # BombData = [row, bombCount, columns...]
            for j in range(BombData[1]):  # BombData[1] = # Bombs in this row
                problem.addBombs(BombData[0], BombData[2 + j])  # BombData[0] = row, BombData[2+j] = columns
        [source_x, source_y] = [int(i) for i in input().split()]
        [dest_x, dest_y] = [int(i) for i in input().split()]
        problem.addSource(source_x, source_y)
        problem.addDestination(dest_x, dest_y)
        # BFS ------------------------------------------------------------------------------------------------
        print(problem.BFS())
        # next testcase --------------------------------------------------------------------------------------
        [row, col] = [int(n) for n in input().split()]


if __name__ == '__main__':
    main()
