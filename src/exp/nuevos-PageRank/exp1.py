import os
import sys
sys.path.append('../../tools')

import subprocess
import re
import graphs

repetitions = 10
c = 0.85
tol = 0.001
dataDirectory = '../../data/exp1'
outDirectory = 'exp1'
executable = '../../tp'

if not os.path.exists(outDirectory):
    os.mkdir(outDirectory)

if not os.path.exists(dataDirectory):
    os.mkdir(dataDirectory)

nodes = [400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000, 4000, 6000, 8000, 10000]
edges = 100000
dataSuffix = dataDirectory + '/exp1-a'
outSuffix = outDirectory + '/exp1-a'

timesFile = outSuffix + '-times.txt'
with open(timesFile, 'w') as f:
    for n in nodes:
        graphFile = dataSuffix + '-' + str(n) + '-graph.txt'
        if not os.path.isfile(graphFile):
            graph = graphs.randomGraph(n, edges)
            graphs.writeGraph(graph, graphFile)

        outFile = outSuffix + '-' + str(n) + '.out.txt'
        f.write(str(n))
        for i in range(repetitions):
            p = subprocess.Popen([executable, '0', str(c), '0', graphFile, str(tol), '-t', '-o', outFile], stdout=subprocess.PIPE)
            f.write(' ' + p.communicate()[0][39:-1])
        f.write('\n')

# Etapa B

nodes = 800
edges = [1000, 5000, 10000, 20000, 40000, 60000, 80000, 100000, 150000, 200000, 300000, 400000, 500000, 600000]
dataSuffix = dataDirectory + '/exp1-b'
outSuffix = outDirectory + '/exp1-b'

timesFile = outSuffix + '-times.txt'
with open(timesFile, 'w') as f:
    for e in edges:
        graphFile = dataSuffix + '-' + str(e) + '-graph.txt'
        if not os.path.isfile(graphFile):
            graph = graphs.randomGraph(nodes, e)
            graphs.writeGraph(graph, graphFile)

        outFile = outSuffix + '-' + str(e) + '.out.txt'
        f.write(str(e))
        for i in range(repetitions):
            p = subprocess.Popen([executable, '0', str(c), '0', graphFile, str(tol), '-t', '-o', outFile], stdout=subprocess.PIPE)
            f.write(' ' + p.communicate()[0][39:-1])
        f.write('\n')
