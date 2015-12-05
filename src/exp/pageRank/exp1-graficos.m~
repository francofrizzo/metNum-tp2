% Procesado de los datos
[c_x, tiempo_y, e, cant] = leer_datos_float('exp1/exp1-data.txt');


% Creación de los gráficos
filetype='-dpdf';
mkdir('graficos');
figure;

hold on;
errorbar(c_x, tiempo_y, e);
axis([c_x(1)-0.05,c_x(length(c_x))+0.05]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
xlabel('Valor de C','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock','FontSize',12);
hold off;
print('graficos/exp1', filetype);