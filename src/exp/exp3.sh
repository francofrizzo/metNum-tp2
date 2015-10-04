#!/bin/bash 

cs=0.85 #c probabilidad de teletransportación
nodos=13
iteraciones=1
tolerancia="0.000001 0.000005 0.00001 0.00005 0.0001 0.0005 0.001 0.005 0.01 0.1 0.3 0.5 0.7" #13

while getopts 'cha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 3. Calculamos el tiempo de ejecución cuando cambiamos el"
       echo "    valor de la tolerancia."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones- por defecto 1"
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp3 ]; then rm $(dirname $0)/exp3 -R; fi
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
mkdir -p $(dirname $0)/exp3 #crear carpeta


python $(dirname $0)/../tools/webparser.py $(dirname $0)/../tools/weblist-exp3.in $(dirname $0)/exp3/exp3-graph.out

for j in $(seq $iteraciones); do 
  for i in $tolerancia; do
      $(dirname $0)/../tp 0 $cs 0 $(dirname $0)/exp3/exp3-graph.out $i -t -o $(dirname $0)/exp3/exp3-n$nodos-t$i.out|
  sed 's/.*: //' |
      while IFS= read -r line; do
        printf " %d \n" "$line" >> $(dirname $0)/exp3/exp3-tiempos-$i.txt ;
      done
  done
done