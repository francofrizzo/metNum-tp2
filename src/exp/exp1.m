% Procesado de los datos
[c_x, tiempo_y, e, cant] = leer_datos_float('exp1/exp1-data.txt');


% Creación de los gráficos
filetype='-dpng';
mkdir('graficos');
figure;

hold on;
errorbar(c_x, tiempo_y, e);
xlabel('Valor de C','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock','FontSize',12);
hold off;
print('graficos/exp1', filetype);