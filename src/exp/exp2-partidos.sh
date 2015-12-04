#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

cs="0.2 0.5 0.8" #c probabilidad de teletransportación
nodos=13
tolerancia=0.00001
algoritmo=0
cantLigas=5

while getopts 'ch' opt; do
  case $opt in
    l) algoritmo=$OPTARG ;;
    h) echo ""
       echo "    Experimento 2 - Ligas Deportivas. Modificamos el "
       echo "    parámetro."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp2-partidos ]; then rm $(dirname $0)/exp2-partidos -R; fi
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
#mkdir -p $(dirname $0)/exp2-partidos #crear carpeta
mkdir -p $(dirname $0)/exp2-partidos/1 #crear carpeta
mkdir -p $(dirname $0)/exp2-partidos/2 #crear carpeta
mkdir -p $(dirname $0)/exp2-partidos/3 #crear carpeta

# for i in $(seq 1 $cantLigas); do
#   for j in $cs; do

#     $(dirname $0)/../tp 0 $j 1 $(dirname $0)/exp2-partidos/liga$i.in $tolerancia -r $(dirname $0)/exp2-partidos/exp2-partidos-liga$i-ranking-C$j.out 

#     #-o $(dirname $0)/exp2-partidos/exp2-partidos-liga$i-C$j.out 
  
#   done
# done

  for j in $cs; do

    $(dirname $0)/../tp 0 $j 1 $(dirname $0)/exp2-partidos/liga-afa1.in $tolerancia -r $(dirname $0)/exp2-partidos/1/exp2-partidos-liga-afa1-ranking-C$j.out -o $(dirname $0)/exp2-partidos/1/exp2-partidos-liga-afa1-C$j.out 

    $(dirname $0)/../tp 0 $j 1 $(dirname $0)/exp2-partidos/liga-afa3.in $tolerancia -r $(dirname $0)/exp2-partidos/3/exp2-partidos-liga-afa3-ranking-C$j.out -o $(dirname $0)/exp2-partidos/3/exp2-partidos-liga-afa3-C$j.out 

    $(dirname $0)/../tp 0 $j 1 $(dirname $0)/exp2-partidos/liga-afa2.in $tolerancia -r $(dirname $0)/exp2-partidos/2/exp2-partidos-liga-afa2-ranking-C$j.out -o $(dirname $0)/exp2-partidos/2/exp2-partidos-liga-afa2-C$j.out 
  
  done