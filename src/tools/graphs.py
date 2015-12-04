import random

def randomGraph(nodes, edges):
    ret = []
    if edges <= nodes * (nodes - 1):
        edgesPerNode = edges // nodes
        for n in range(edges % nodes):
            ret.append(random.sample([x for x in range(nodes) if x != n], edgesPerNode + 1));
        for n in range(edges % nodes, nodes):
            ret.append(random.sample([x for x in range(nodes) if x != n], edgesPerNode))
    else:
        raise Exception("Too many edges (" + str(edges) + ") for that amount of nodes (" + str(nodes) + ")")
    return ret

def writeGraph(graph, graphFile):
    nlinks = 0
    for i in range(len(graph)):
        nlinks += len(graph[i])
    with open(graphFile,'w') as f:
        #f.write(str(len(graph))+'\n')
        #f.write(str(nlinks)+'\n')
        f.write('# Directed graph (each unordered pair of nodes is saved once):\n') 
        f.write('# Generated randomly with edges evenly distributed among nodes\n')
        f.write('# Nodes: ' + str(len(graph)) + ' Edges: ' + str(nlinks) + ' \n') 
        f.write('# FromNodeId   ToNodeId\n')
        for i in range(len(graph)):
            for j in range(len(graph[i])):
                f.write(str(i+1) + '\t' + str(graph[i][j]+1) + '\n')
