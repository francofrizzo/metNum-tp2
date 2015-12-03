% Procesado de los datos
[links_a_x, tiempos_y, e, cant] = leer_datos('exp2/exp2-data.txt');
[links_b_x, iteraciones_y, e, cant] = leer_datos('exp2/exp2-iteraciones.txt');

tiempo_y = tiempos_y ./ iteraciones_y;


% Creación de los gráficos
filetype='-dpdf';
mkdir('graficos');
figure;

hold on;
errorbar(links_a_x, tiempo_y, e);
axis([links_a_x(1)-1,links_a_x(length(links_a_x))+1]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
%IMPORTANTE! Arriba puse -1 y +1 para dejar un borde a los costados y que la función no se pegue totalmente a los bordes, pero tampoco haya demasiado espacio de más. Este valor se puede cambiar si el gráfico esta quedando mal. Como no tengo los datos, no se cual seria el valor adecuado. -Manu
xlabel('Cantidad de links','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock normalizado por cantidad de iteraciones','FontSize',10);
hold off;
print('graficos/exp2', filetype);