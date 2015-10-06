#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

cs="0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1"
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
    exit 1
fi

echo "Generando datos de entrada...";
mkdir -p $(dirname $0)/exp1-partidos #crear carpeta

  for j in $(seq $iteraciones); do 
      for i in $cs ; do
        $(dirname $0)/../tp 1 $i 0 $(dirname $0)/partidos-exp1.out $tolerancia -r $(dirname $0)/exp1-partidos/exp1-ranking-$i.out -t -o $(dirname $0)/exp1-partidos/exp1-$i.out |
        sed 's/.*: //' |
        while IFS= read -r line; do
          printf " %d \n" $line >> $(dirname $0)/exp1-partidos/exp1-partidos-tiempos.txt ;
        done
      done
  done