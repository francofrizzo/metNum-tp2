% Procesado de los datos
[links_a_x, tiempos_y, e, cant] = leer_datos('exp2/exp2-data.txt');
[links_b_x, iteraciones_y, e, cant] = leer_datos('exp2/exp2-iteraciones.txt');

tiempo_y = tiempos_y ./ iteraciones_y;


% Creación de los gráficos
filetype='-dpng';
mkdir('graficos');
figure;

hold on;
errorbar(links_a_x, tiempo_y, e);
xlabel('Cantidad de links','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock normalizado por cantidad de iteraciones','FontSize',10);
hold off;
print('graficos/exp2', filetype);