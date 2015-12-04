#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

cs=0.6 #c probabilidad de teletransportación
nodos=13
tolerancia=0.00001
algoritmo=0
cantLigas=5
k="$(seq 0 1 10)"
cc="0.1 0.15 0.2 0.25 0.3 0.35" #este es el c2

while getopts 'ch' opt; do
  case $opt in
    l) algoritmo=$OPTARG ;;
    h) echo ""
       echo "    Experimento 3 - Ligas Deportivas. Comparamos los 3 métodos "
       echo "    de puntuar los empates."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp3-partidos ]; then rm $(dirname $0)/exp3-partidos -R; fi
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
#mkdir -p $(dirname $0)/exp3-partidos #crear carpeta

for i in $(seq 1 $cantLigas); do
  for j in $k; do

    $(dirname $0)/../tp 0 $cs 1 $(dirname $0)/exp3-partidos/liga$i.in $tolerancia -r $(dirname $0)/exp3-partidos/exp3-partidos-liga$i-ranking-K$j.out -o $(dirname $0)/exp3-partidos/exp3-partidos-liga$i-K$j.out -1 $j
  
  done
  for j in $cc; do

    $(dirname $0)/../tp 0 $cs 1 $(dirname $0)/exp3-partidos/liga$i.in $tolerancia -r $(dirname $0)/exp3-partidos/exp3-partidos-liga$i-ranking-c2$j.out -o $(dirname $0)/exp3-partidos/exp3-partidos-liga$i-c2$j.out -2 $j 
  
  done
done