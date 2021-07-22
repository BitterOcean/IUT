import heapq
import networkx as nx
import matplotlib.pyplot as plt
from collections import defaultdict
import numpy as np



class getGraph:

    def __init__(self, edge_file):
        self.edge_file = edge_file

    def get_connections(self):
        edge_list = []
        edges = defaultdict(list)

        with open (self.edge_file, 'r') as e_file:
            edge_list = e_file.readlines()

        for edge in edge_list:
            from_, to_ = edge.split('\t')
            from_, to_ = int(from_), int(to_[:-1])
            edges[from_].append(to_)
        return edges


class plotGraph:

    def __init__(self, edges, interval=5000):
        self.edges = edges
        self.interval = interval
    
    def get_KMaxRankNodes(self, number_of_nodes, rank_vector):
        heaped_ranks = [(rank, node) for (node, rank) in 
            enumerate(rank_vector)]
        heapq._heapify_max(heaped_ranks)
        topK = [heapq._heappop_max(heaped_ranks)
            for _ in range(number_of_nodes)]
        return topK


    def get_edgesConnectedToTopK(self, rank_vector, topK, ranks):
        weighed_edges = defaultdict(list)
        for couple in topK:
            weighed_edges[(couple[1], couple[0])] = [(node, ranks[node]) 
                for node in self.edges[couple[1]]]
        return weighed_edges


    def get_EdgesToDrawWithRanks(self, drawing_list, ranks):
        edge_list=[]
        to_draw_node_set = set();
        for (node, rank) in drawing_list:
            to_draw_node_set.add(node)
            for child in drawing_list[(node, rank)]:
                to_draw_node_set.add(child[0])
                edge_list.append((node, child[0]))

        nodes_to_draw = [(node, ranks[node]) for node in to_draw_node_set]
        return (edge_list, nodes_to_draw)
    
    def draw(self, edge_list, nodes_to_draw):
        Graph = nx.DiGraph()
        Graph.add_edges_from(sorted(edge_list))
        d = dict()
        for edge in edge_list:
            if edge[0] not in d:
                d[edge[0]] = edge

        print(list(d))
        fig = plt.figure()
        timer = fig.canvas.new_timer(self.interval)
        timer.add_callback(plt.close)

        pos = nx.shell_layout(Graph)
        nx.draw_networkx_nodes(Graph, 
                pos, 
                cmap=plt.get_cmap('jet'), 
                node_size=[node[1]*1 for node in nodes_to_draw])
        nx.draw_networkx_labels(Graph, pos, labels={node[0]: node[0] for node in nodes_to_draw})
        nx.draw_networkx_edges(Graph, pos, arrows=True)
        timer.start()
        plt.show()

            
            
    def plot(self, number_of_nodes, rank_vector):

        ranks = {node: rank for (node, rank) in enumerate(rank_vector)}
        topK = self.get_KMaxRankNodes(number_of_nodes, rank_vector)
        drawing_list = self.get_edgesConnectedToTopK(rank_vector, topK, ranks)
        
        (edge_list, nodes_to_draw) = self.get_EdgesToDrawWithRanks(drawing_list, ranks)
       
        self.draw(edge_list, nodes_to_draw)
