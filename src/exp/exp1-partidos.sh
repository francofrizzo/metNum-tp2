#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

cs=0.85
iteraciones=1
tolerancia=0.00001


while getopts 'cha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 1 - Ligas Deportivas. Compara contra el "
       echo "    ranking de la AFA. "
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones- por defecto 1"
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp1-partidos ]; then rm $(dirname $0)/exp1-partidos -R; fi
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
mkdir -p $(dirname $0)/exp1-partidos #crear carpeta
      
      $(dirname $0)/../tp 1 $cs 1 $(dirname $0)/partidos-exp1.out $tolerancia -r $(dirname $0)/exp1-partidos/exp1-ranking-$i-afa.out -t -o $(dirname $0)/exp1-partidos/exp1-$i-afa.out

      $(dirname $0)/../tp 0 $cs 1 $(dirname $0)/partidos-exp1.out $tolerancia -r $(dirname $0)/exp1-partidos/exp1-ranking-$i-page.out -t -o $(dirname $0)/exp1-partidos/exp1-$i-page.out

