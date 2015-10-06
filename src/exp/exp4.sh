#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

cs=0.85 #c probabilidad de teletransportación
nodos=13
tolerancia=0.00001
algoritmo=0

while getopts 'ch' opt; do
  case $opt in
    l) algoritmo=$OPTARG ;;
    h) echo ""
       echo "    Experimento 2. Calcula el tiempo de ejecución cuando variamos la "
       echo "    cantidad de nodos."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp4 ]; then rm $(dirname $0)/exp4 -R; fi
       exit 0 ;;
  esac
done

echo "Compilando..."

make -s -C $(dirname $0)/..
if [ $? -ne 0 ]; then
    echo "ERROR: Error de compilación."
    exit 1
fi

echo "Generando datos de entrada...";
mkdir -p $(dirname $0)/exp4 #crear carpeta

  python $(dirname $0)/../tools/webparser.py $(dirname $0)/../tools/weblist-exp4-1.in $(dirname $0)/exp4/exp4-graph-1.out


  $(dirname $0)/../tp 0 $cs 0 $(dirname $0)/exp4/exp4-graph-1.out $tolerancia -r $(dirname $0)/exp4/exp4-ranking-1-PageRank.out -o $(dirname $0)/exp4/exp4-1-$algoritmo.out 

  $(dirname $0)/../tp 0 $cs 0 $(dirname $0)/exp4-graph-2.out $tolerancia -r $(dirname $0)/exp4/exp4-ranking-2-PageRank.out -o $(dirname $0)/exp4/exp4-2-$algoritmo.out

  $(dirname $0)/../tp 1 $cs 0 $(dirname $0)/exp4/exp4-graph-1.out $tolerancia -r $(dirname $0)/exp4/exp4-ranking-1-INDEG.out -o $(dirname $0)/exp4/exp4-1-$algoritmo.out
      
  $(dirname $0)/../tp 1 $cs 0 $(dirname $0)/exp4-graph-2.out $tolerancia -r $(dirname $0)/exp4/exp4-ranking-2-INDEG.out -o $(dirname $0)/exp4/exp4-2-$algoritmo.out
