import os
import sys
sys.path.append('../../tools')

import subprocess
import re
import graphs

instances = [
    {'id': '1', 'graph': [[2,3,4,5,6,7],[0],[3,7],[2,4],[3,5],[4,6],[5,7]]},
    {'id': '2', 'graph': [[1,2,3,4,5,6,7],[0],[3,4,5,6,7],[],[],[],[],[]]},
    {'id': '3', 'graph': [[3],[0],[1],[2],[5],[4]]}
]
c = 0.85
tol = 0.001
dataDirectory = '../../data/exp3'
outDirectory = 'exp3'
executable = '../../tp'

if not os.path.exists(outDirectory):
    os.mkdir(outDirectory)

if not os.path.exists(dataDirectory):
    os.mkdir(dataDirectory)

dataSuffix = dataDirectory + '/exp3'
outSuffix = outDirectory + '/exp3'

for i in instances:
    print "Procesando instancia " + i['id']

    graphFile = dataSuffix + '-' + i['id'] + '-graph.txt'
    
    if not os.path.isfile(graphFile):
        print '  Generando datos de entrada'
        graphs.writeGraph(i['graph'], graphFile)

    for j in [0, 1]:
        print '  Corriendo algoritmo ' + str(j)
        outFile = outSuffix + '-' + i['id'] + '-' + str(j) + '.out.txt'
        subprocess.call([executable, str(j), str(c), '0', graphFile, str(tol), '-o', outFile])
