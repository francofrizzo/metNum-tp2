import os
import sys
sys.path.append('../../tools')

import subprocess
import re
import graphs

from oct2py import octave

repetitions = 20
c = 0.85
tol = 0.001
dataDirectory = '../../data/exp1'
outDirectory = 'exp1'
executable = '../../tp'

if not os.path.exists(outDirectory):
    os.mkdir(outDirectory)

if not os.path.exists(dataDirectory):
    os.mkdir(dataDirectory)

# # Etapa A
# print 'Etapa A'

# nodes = [400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000, 4000, 6000, 8000, 10000, 20000, 40000, 60000, 80000, 100000]
# edges = 100000
# dataSuffix = dataDirectory + '/exp1-a'
# outSuffix = outDirectory + '/exp1-a'

# timesFile = outSuffix + '-times.txt'
# with open(timesFile, 'w') as f:
#     f.write(str(repetitions) + '\n')
#     for n in nodes:
#         print '  Corriendo instancia con ' + str(n) + ' nodos'
#         graphFile = dataSuffix + '-' + str(n) + '-graph.txt'
#         if not os.path.isfile(graphFile):
#             print '    Generando datos de entrada'
#             graph = graphs.randomGraph(n, edges)
#             graphs.writeGraph(graph, graphFile)

#         outFile = outSuffix + '-' + str(n) + '.out.txt'
#         f.write(str(n))
#         sys.stdout.write('    Repeticiones:')
#         sys.stdout.flush()
#         for i in range(repetitions):
#             sys.stdout.write(' ' + str(i + 1))
#             sys.stdout.flush()
#             p = subprocess.Popen([executable, '0', str(c), '0', graphFile, str(tol), '-t', '-o', outFile], stdout=subprocess.PIPE)
#             f.write(' ' + p.communicate()[0][39:-1])
#         sys.stdout.write('\n')
#         f.write('\n')

# # Etapa B
# print 'Etapa B'

# nodes = 1050
# edges = [1000, 5000, 10000, 20000, 40000, 60000, 80000, 100000, 150000, 200000, 300000, 400000, 500000, 600000, 800000, 1000000]
# dataSuffix = dataDirectory + '/exp1-b'
# outSuffix = outDirectory + '/exp1-b'

# timesFile = outSuffix + '-times.txt'
# with open(timesFile, 'w') as f:
#     f.write(str(repetitions) + '\n')
#     for e in edges:
#         print '  Corriendo instancia con ' + str(e) + ' enlaces'
#         graphFile = dataSuffix + '-' + str(e) + '-graph.txt'
#         if not os.path.isfile(graphFile):
#             print '    Generando datos de entrada'
#             graph = graphs.randomGraph(nodes, e)
#             graphs.writeGraph(graph, graphFile)

#         outFile = outSuffix + '-' + str(e) + '.out.txt'
#         f.write(str(e))
#         sys.stdout.write('    Repeticiones:')
#         sys.stdout.flush()
#         for i in range(repetitions):
#             sys.stdout.write(' ' + str(i + 1))
#             sys.stdout.flush()
#             p = subprocess.Popen([executable, '0', str(c), '0', graphFile, str(tol), '-t', '-o', outFile], stdout=subprocess.PIPE)
#             f.write(' ' + p.communicate()[0][39:-1])
#         sys.stdout.write('\n')
#         f.write('\n')

# Graficos
octave.exp1()
