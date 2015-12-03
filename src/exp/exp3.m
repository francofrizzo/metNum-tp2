% Procesado de los datos
[tolerancia_x, tiempo_y, e, cant] = leer_datos_float('exp3/exp3-data.txt');


% Creación de los gráficos
filetype='-dpdf';
mkdir('graficos');
figure;

hold on;
axis([tolerancia_x(1)-0.05,tolerancia_x(length(tolerancia_x))+0.05]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
h = errorbar(tolerancia_x, tiempo_y, e);
xlabel('Valor de tolerancia','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock','FontSize',12);
set(get(h, 'Parent'), 'YScale', 'log');
hold off;
print('graficos/exp3', filetype);