#include <iostream> 
#include <limits.h> 
#include <string.h> 
#include <queue> 
#include <vector>

using namespace std;

int max_flow = 0; // There is no flow initially 

/* Returns true if there is a path from source 's' to sink 't' in
residual graph. Also fills parent[] to store the path */
bool bfs(vector<vector<int>> rGraph, int vertex, int s, int t, vector<int> &parent)
{
	// Create a visited array and mark all vertices as not visited 
	vector<bool> visited(vertex);
	for (int i = 0; i < vertex; i++)
		visited[i] = false;

	// Create a queue, enqueue source vertex and mark source vertex 
	// as visited 
	queue <int> q;
	q.push(s);
	visited[s] = true;
	parent[s] = -1;

	// Standard BFS Loop 
	while (!q.empty())
	{
		int u = q.front();
		q.pop();

		for (int v = 0; v < vertex; v++)
		{
			if (visited[v] == false && rGraph[u][v] > 0)
			{
				q.push(v);
				parent[v] = u;
				visited[v] = true;
			}
		}
	}

	// If we reached sink in BFS starting from source, then return 
	// true, else false 
	return (visited[t] == true);
}

// Returns the maximum flow from s to t in the given graph 
vector<int> fordFulkerson(vector<vector<int>> graph, int vertex, int s, int t)
{
	int u, v;

	// Create a residual graph and fill the residual graph with 
	// given capacities in the original graph as residual capacities 
	// in residual graph 
	vector<vector<int>> rGraph(vertex, vector<int>(vertex)); // Residual graph where rGraph[i][j] indicates 
					// residual capacity of edge from i to j (if there 
					// is an edge. If rGraph[i][j] is 0, then there is not) 
	for (u = 0; u < vertex; u++)
		for (v = 0; v < vertex; v++)
			rGraph[u][v] = graph[u][v];

	vector<int> parent(vertex); // This array is filled by BFS and to store path 

	max_flow = 0; // There is no flow initially 

	// Augment the flow while tere is path from source to sink 
	while (bfs(rGraph, vertex, s, t, parent))
	{
		// Find minimum residual capacity of the edges along the 
		// path filled by BFS. Or we can say find the maximum flow 
		// through the path found. 
		int path_flow = INT_MAX;
		for (v = t; v != s; v = parent[v])
		{
			u = parent[v];
			path_flow = min(path_flow, rGraph[u][v]);
		}

		// update residual capacities of the edges and reverse edges 
		// along the path 
		for (v = t; v != s; v = parent[v])
		{
			u = parent[v];
			rGraph[u][v] -= path_flow;
			rGraph[v][u] += path_flow;
		}

		// Add path flow to overall flow 
		max_flow += path_flow;
	}
	
	// Return the path
	return parent;
}

// Driver program to test above functions 
int main()
{
	int vertex , a , source , sink;
	cout << "Please Enter the Number of the nodes : "; 
	cin >> vertex;
	cout << "\nPlease Enter the source nodes : ";
	cin >> source;
	cout << "\nPlease Enter sink  nodes : ";
	cin >> sink;
	vector<vector<int>> Graph(vertex, vector<int>(vertex));
	cout << "\nPlease Enter the Graph :" << endl;
	for (int i = 0; i < vertex; i++)
		for (int j = 0; j < vertex; j++)
		{
			cin >> a;
			Graph[i][j] = a;
		}

	vector<int> Path;
	int p = sink;
	while (fordFulkerson(Graph, vertex, source, sink)[p] != -1)
	{
			Path.push_back(fordFulkerson(Graph, vertex, source, sink)[p]) ;
			p = fordFulkerson(Graph, vertex, source, sink)[p];
	}

	cout << endl << "The path is : ";
	for (int i = Path.size()-1; i >= 0 ; i--)
		cout << Path[i] << " -> ";
	cout << sink << endl;
	
	cout << endl << "The maximum flow of the path is : " << max_flow << endl;

	getchar();
	getchar();
	return 0;
}
