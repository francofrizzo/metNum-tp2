#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

cs="0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1"
iteraciones=1
tolerancia=0.00001

while getopts 'cha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 1. Calculamos cuantos ciclos ejecuta para llegar a tener menor"
       echo "    tolerancia que la pasada para distintos C."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones- por defecto 1"
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
echo "Generando datos de entrada...";
mkdir -p $(dirname $0)/exp1 #crear carpeta
python $(dirname $0)/../tools/webparser.py $(dirname $0)/../tools/weblist-exp1.in $(dirname $0)/exp1/exp1-graph.out

#echo "$iteraciones" #DEBUG

printf "%d\n" $iteraciones >> $(dirname $0)/exp1/exp1-data.txt

for i in $cs; do
  printf "%f"  $i >> $(dirname $0)/exp1/exp1-data.txt
  for j in $(seq 1 $iteraciones); do 
      $(dirname $0)/../tp 0 $i 0 $(dirname $0)/exp1/exp1-graph.out $tolerancia -t -o $(dirname $0)/exp1/exp1-c$i.out|
  sed 's/.*: //' |
      while IFS= read -r line; do
        printf " %d" "$line" >> $(dirname $0)/exp1/exp1-data.txt 
      done
  done
  printf "\n" >> $(dirname $0)/exp1/exp1-data.txt
done

octave -q $(dirname $0)/exp1.m
