% Procesado de los datos
[tolerancia_x, tiempo_y, e, cant] = leer_datos_float('exp3/exp3-data.txt');


% Creación de los gráficos
filetype='-dpng';
mkdir('graficos');
figure;

hold on;
errorbar(tolerancia_x, tiempo_y, e);
xlabel('Valor de tolerancia','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock','FontSize',12);
hold off;
print('graficos/exp3', filetype);