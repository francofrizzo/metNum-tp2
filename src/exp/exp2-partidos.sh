#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

cs=0.85
iteraciones=1
tolerancia=0.00001


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
    c) if [ -d $(dirname $0)/exp4 ]; then rm $(dirname $0)/exp4 -R; fi
       exit 0 ;;
  esac
done

echo "Compilando..."

make -s -C $(dirname $0)/..
if [ $? -ne 0 ]; then
    echo "ERROR: Error de compilación."
    exit 1s
fi

echo "Generando datos de entrada...";
mkdir -p $(dirname $0)/exp2-partidos #crear carpeta

  for j in $(seq $iteraciones); do 
      for i in $cs ; do
        $(dirname $0)/../tp 1 $cs 0 $(dirname $0)/exp2-partidos/exp2-graph-$i-afa.out $tolerancia -r $(dirname $0)/exp2-partidos/exp2-ranking-$i-afa.out -t -o $(dirname $0)/exp2-partidos/exp1-$i-afa.out|

         $(dirname $0)/../tp 0 $cs 0 $(dirname $0)/exp2-partidos/exp2-graph-$i-page.out $tolerancia -r $(dirname $0)/exp2-partidos/exp2-ranking-$i-page.out -t -o $(dirname $0)/exp2-partidos/exp1-$i-page.out|

        sed 's/.*: //' |
        while IFS= read -r line; do
          printf " %d \n" "$line" >> $(dirname $0)/exp2-partidos/exp2-partidos-tiempos.txt ;
        done
      done
  done