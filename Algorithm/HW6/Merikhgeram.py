from collections import defaultdict

SCC = []
component = []


# This class represents a directed graph using adjacency list representation
class Graph:

    def __init__(self, vertices):
        self.V = vertices  # No. of vertices
        self.graph = defaultdict(list)  # default dictionary to store graph

    # function to add an edge to graph
    def addEdge(self, u, v):
        self.graph[u].append(v)

    # A function used by DFS
    def DFSUtil(self, v, visited):
        # Mark the current node as visited and print it
        visited[v] = True
        component.append(v)
        # Recur for all the vertices adjacent to this vertex
        for i in self.graph[v]:
            if visited[i] == False:
                self.DFSUtil(i, visited)

    def fillOrder(self, v, visited, stack):
        # Mark the current node as visited
        visited[v] = True
        # Recur for all the vertices adjacent to this vertex
        for i in self.graph[v]:
            if visited[i] == False:
                self.fillOrder(i, visited, stack)
        stack = stack.append(v)

    # Function that returns reverse (or transpose) of this graph
    def getTranspose(self):
        g = Graph(self.V)

        # Recur for all the vertices adjacent to this vertex
        for i in self.graph:
            for j in self.graph[i]:
                g.addEdge(j, i)
        return g

    # The main function that finds and prints all strongly
    # connected components
    def findSCCs(self):

        global component
        stack = []
        # Mark all the vertices as not visited (For first DFS)
        visited = [False] * self.V
        # Fill vertices in stack according to their finishing
        # times
        for i in range(self.V):
            if visited[i] == False:
                self.fillOrder(i, visited, stack)

            # Create a reversed graph
        gr = self.getTranspose()

        # Mark all the vertices as not visited (For second DFS)
        visited = [False] * self.V

        # Now process all vertices in order defined by Stack
        while stack:
            i = stack.pop()
            if visited[i] == False:
                gr.DFSUtil(i, visited)
                SCC.append(component)
                component = []


if __name__ == "__main__":
    counter = 0
    check_comp = 0
    V = int(input())
    g = Graph(V)
    for j in range(V):
        followers = input().split()
        num = int(followers[0])
        for i in range(0, num):
            v = int(followers[i + 1])
            g.addEdge(j, v - 1)

    g.findSCCs()
    edge_in = []
    val = list(g.graph.values())
    for i in range(len(val)):
        for j in range(len(val[i])):
            edge_in.append(val[i][j])

    for c in range(len(SCC)):
        if len(SCC[c]) == 1 and not SCC[c][0] in edge_in:
            counter += 1
        elif len(SCC[c]) > 1:
            check_comp = 0
            for i in range(len(SCC[c])):
                if edge_in.count(SCC[c][i]) == 1:
                    check_comp += 1
                if check_comp == len(SCC[c]):
                    counter += 1

    print(counter)

