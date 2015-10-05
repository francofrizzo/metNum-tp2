#!/bin/bash 

cs=0.85 #c probabilidad de teletransportación
nodos=13
iteraciones=1
tolerancia=0.00001
#cantPag="$(seq 5 5 30)"

while getopts 'cha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 2. Calcula el tiempo de ejecución cuando variamos la "
       echo "    cantidad de nodos."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones- por defecto 1"
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp2 ]; then rm $(dirname $0)/exp2 -R; fi
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

for k in $(seq 5 5 30); do
  python $(dirname $0)/../tools/webparser.py $(dirname $0)/../tools/weblist-exp2-$k.in $(dirname $0)/exp2/exp2-graph-$k.out
done


for j in $(seq $iteraciones); do 
  for i in $(seq 5 5 30); do
      $(dirname $0)/../tp 0 $cs 0 $(dirname $0)/exp2/exp2-graph-$i.out $tolerancia -r $(dirname $0)/exp2/exp2-ranking-$i.out -t -o $(dirname $0)/exp2/exp2-$i.out|

  sed 's/.*: //' |
      while IFS= read -r line; do
        printf " %d \n" "$line" >> $(dirname $0)/exp2/exp2-tiempos.txt ;
      done
  done
done