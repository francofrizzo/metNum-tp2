#!/bin/bash 

cs="0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1"
aristas=1
nodos=2
tolerancia=0.00001
verbose=false

while getopts 'n:a:chv' opt; do
  case $opt in
    n) nodos=$OPTARG ;;
	a) aristas=$OPTARG ;;
    v) verbose=true ;;
    h) echo ""
       echo "    Experimento 1. Calculamos cuantos ciclos ejecuta para llegar a tener menor"
       echo "    tolerancia que la pasada para distintos C."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Determina la cantidad de aristas- por defecto 1"
       echo "		 -n <núm>  Cantidad de Nodos- por defecto 2"
       echo "        -v        Muestra más información por pantalla."
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp1 ]; then rm $(dirname $0)/exp1 -R; fi
       exit 0 ;;
  esac
done

echo "Compilando..."

make -s -C $(dirname $0)/..
if [ $? -ne 0 ]; then
    echo "ERROR: Error de compilación."
    exit 1
fi

echo "Generando datos de entrada..."
mkdir -p $(dirname $0)/exp1 #crear carpeta
# python $(dirname $0)/../tools/webparser.py $(dirname $0)/../tools/weblist.in $(dirname $0)/exp1/exp1-graph.out
for i in $cs; do
    $(dirname $0)/../tp 0 $i 0 $(dirname $0)/exp1/exp1-graph.out $tolerancia -t -o $(dirname $0)/exp1/exp1-a$aristas-n$nodos-c$i.out|

sed 's/Cantidad de iteraciones: //' |
while IFS= read -r line; do
 	if [ "$verbose" = true ]; then
    printf "    Tamaño: %8s.    Tiempo insumido: %12s\n" "$t" "$line"
    fi
    printf " %d" "$line" >> $(dirname $0)/exp1/data-diff-$imp.txt
    done
done
