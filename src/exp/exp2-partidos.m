% Procesado de los datos
[equipos_x_1_a, puntaje_y_1_a, e_1_a, cant_1_a] = leer_datos_float('exp2-partidos/exp2-partidos-1-0.2.out');
[equipos_x_1_b, puntaje_y_1_b, e_1_b, cant_1_b] = leer_datos_float('exp2-partidos/exp2-partidos-1-0.5.out');
[equipos_x_1_c, puntaje_y_1_c, e_1_c, cant_1_c] = leer_datos_float('exp2-partidos/exp2-partidos-1-0.8.out');


% Creación de los gráficos
filetype='-dpdf';
mkdir('graficos');
figure;

hold on;
%axis([tolerancia_x(1)-0.05,tolerancia_x(length(tolerancia_x))+0.05]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
stem(puntaje_y_1_a, equipos_x_1_a, 'LineStyle', 'none', 'Marker', 'o', '-g');
stem(puntaje_y_1_b, equipos_x_1_b, 'LineStyle', 'none', 'Marker', 'x', '-b');
stem(puntaje_y_1_c, equipos_x_1_c, 'LineStyle', 'none', 'Marker', 'd', '-r');

xlabel('Equipos','FontSize',12);
ylabel('Puntaje','FontSize',12);

legend('C = 0.2','C = 0.5','C = 0.8','Location','southwest');

hold off;
print('graficos/exp2-partidos-liga-afa1', filetype);

%=====================================================================================================

% Procesado de los datos
[equipos_x_2_a, puntaje_y_2_a, e_2_a, cant_2_a] = leer_datos_float('exp2-partidos/exp2-partidos-2-0.2.out');
[equipos_x_2_b, puntaje_y_2_b, e_2_b, cant_2_b] = leer_datos_float('exp2-partidos/exp2-partidos-2-0.5.out');
[equipos_x_2_c, puntaje_y_2_c, e_2_c, cant_2_c] = leer_datos_float('exp2-partidos/exp2-partidos-2-0.8.out');

hold on;
%axis([tolerancia_x(1)-0.05,tolerancia_x(length(tolerancia_x))+0.05]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
stem(puntaje_y_2_a, equipos_x_2_a, 'LineStyle', 'none', 'Marker', 'o', '-g');
stem(puntaje_y_2_b, equipos_x_2_b, 'LineStyle', 'none', 'Marker', 'x', '-b');
stem(puntaje_y_2_c, equipos_x_2_c, 'LineStyle', 'none', 'Marker', 'd', '-r');

xlabel('Equipos','FontSize',12);
ylabel('Puntaje','FontSize',12);

legend('C = 0.2','C = 0.5','C = 0.8','Location','southwest');

hold off;
print('graficos/exp2-partidos-liga-afa2', filetype);

%=====================================================================================================

% Procesado de los datos
[equipos_x_3_a, puntaje_y_3_a, e_3_a, cant_3_a] = leer_datos_float('exp2-partidos/exp2-partidos-3-0.2.out');
[equipos_x_3_b, puntaje_y_3_b, e_3_b, cant_3_b] = leer_datos_float('exp2-partidos/exp2-partidos-3-0.5.out');
[equipos_x_3_c, puntaje_y_3_c, e_3_c, cant_3_c] = leer_datos_float('exp2-partidos/exp2-partidos-3-0.8.out');

hold on;
%axis([tolerancia_x(1)-0.05,tolerancia_x(length(tolerancia_x))+0.05]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
stem(puntaje_y_3_a, equipos_x_3_a, 'LineStyle', 'none', 'Marker', 'o', '-g');
stem(puntaje_y_3_b, equipos_x_3_b, 'LineStyle', 'none', 'Marker', 'x', '-b');
stem(puntaje_y_3_c, equipos_x_3_c, 'LineStyle', 'none', 'Marker', 'd', '-r');

xlabel('Equipos','FontSize',12);
ylabel('Puntaje','FontSize',12);

legend('C = 0.2','C = 0.5','C = 0.8','Location','southwest');

hold off;
print('graficos/exp2-partidos-liga-afa3', filetype);

