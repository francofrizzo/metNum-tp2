import os
import sys
sys.path.append('../../tools')

import subprocess
import re
import graphs

instances = [
    # {'id': 'a', 'generated': True},
    # {'id': 'b', 'generated': False},
    {'id': 'c', 'generated': False}
]
cs = [0.85]
tol = 0.001
dataDirectory = '../../data/exp2'
outDirectory = 'exp2'
executable = '../../tp'

if not os.path.exists(outDirectory):
    os.mkdir(outDirectory)

if not os.path.exists(dataDirectory):
    print "No se encuentra el directorio con los archivos de entrada"
    exit(1)

dataSuffix = dataDirectory + '/exp2'
outSuffix = outDirectory + '/exp2'

for i in instances:
    print "Procesando instancia " + str(i['id'])

    graphFile = dataSuffix + '-' + str(i['id']) + '-graph.txt'
    
    if i['generated'] and not os.path.isfile(graphFile):
        print "  Generando datos de entrada"
        webfile = dataSuffix + '-' + str(i['id']) + '-webs.txt'
        webparser.parse(webfile, graphFile)

    for c in cs:
        print "  Corriendo con c = " + str(c)
        outFile = outSuffix + '-' + str(i['id']) + '-' + str(c) + '.out.txt'
        convergFile = outSuffix + '-' + str(i['id']) + '-' + str(c) + '-converg.txt'
        subprocess.call([executable, '0', str(c), '0', graphFile, str(tol), '-v', convergFile, '-o', outFile])
