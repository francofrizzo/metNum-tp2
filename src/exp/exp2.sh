#!/bin/bash 

cs=0.85 #c probabilidad de teletransportación
nodos=13
iteraciones=1
tolerancia=0.00001
cantPag="$(seq 5 5 30)"

while getopts 'cha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 2. Calculas el tiempo de ejecuión cuando variamos la "
       echo "    cantidad de nodos."
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
mkdir -p $(dirname $0)/exp2 #crear carpeta

for k in $cantPag; do
  python $(dirname $0)/../tools/webparser.py $(dirname $0)/../tools/weblist-exp2-$k.in $(dirname $0)/exp2/exp2-graph-$k.out
done


for j in $iteraciones; do 
  for i in $cantPag; do
      $(dirname $0)/../tp 0 $i 0 $(dirname $0)/exp2/exp2-graph.out $tolerancia -t -o $(dirname $0)/exp2/exp2-n$nodos-$i.out|
  sed 's/.*: //' |
      while IFS= read -r line; do
        printf " %d \n" "$line" >> $(dirname $0)/exp2/exp2-tiempos-$i.txt ;
      done
  done
done