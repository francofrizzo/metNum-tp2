import os
import sys
sys.path.append('../../tools')

import subprocess
import re
import graphs

from oct2py import octave

instances = [
    {'id': 'a', 'generated': True},
    {'id': 'b', 'generated': False},
    {'id': 'c', 'generated': False}
]
params = [
    {'c': '0.85', 'tol':'0.001'},
    {'c': '0.90', 'tol':'0.001'},
    {'c': '0.95', 'tol':'0.001'},
    {'c': '0.99', 'tol':'0.001'}
]
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
    print "Procesando instancia " + i['id']

    graphFile = dataSuffix + '-' + i['id'] + '-graph.txt'
    
    if i['generated'] and not os.path.isfile(graphFile):
        print "  Generando datos de entrada"
        webfile = dataSuffix + '-' + i['id'] + '-webs.txt'
        webparser.parse(webfile, graphFile)

    for p in params:
        print "  Corriendo con c = " + p['c']
        outFile = outSuffix + '-' + i['id'] + '-' + p['c'] + '.out.txt'
        convergFile = outSuffix + '-' + i['id'] + '-' + p['c'] + '-converg.txt'
        subprocess.call([executable, '0', p['c'], '0', graphFile, p['tol'], '-v', convergFile, '-o', outFile])

# Graficos
octave.exp2()
