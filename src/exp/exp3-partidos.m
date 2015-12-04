%Experimento 3 - Partidos
ks=[0, 2, 5];
cs=[0.1, 0.25, 0.4];
ligas=[2, 4, 5];

% Creación de los gráficos
filetype='-dpdf';
mkdir('graficos');
figure;


for i = ligas
	clf;
	for j = ks
		textFileName0 = ['exp3-partidos/datosGraf/exp3-liga' num2str(i) '-grafK-' num2str(j) '.out'];
		[equipos_x, puntaje_y, e, cant] = leer_datos_float(textFileName0);

		hold on;
		axis([puntaje_y(1)-0.25,puntaje_y(length(puntaje_y))+0.25]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio

		if j == 0
			stem(puntaje_y, equipos_x, 'LineStyle', 'none', 'Marker', 'o', '-g');
		elseif j == 2
			stem(puntaje_y, equipos_x, 'LineStyle', 'none', 'Marker', 'x', '-b');
		else
			stem(puntaje_y, equipos_x, 'LineStyle', 'none', 'Marker', 'd', '-r');
		end
		xlabel('Equipos','FontSize',12);
		ylabel('Puntaje','FontSize',12);

		legend('K = 0','K = 2','K = 5','Location','southwest');
		hold off;
	end
	textFileName1 = ['graficos/exp3-partidos-liga' num2str(i) '-K'];
	print(textFileName1, filetype);
	clf;
	filetype='-dpdf';

	for h = cs
		textFileName0 = ['exp3-partidos/datosGraf/exp3-liga' num2str(i) '-grafC-' num2str(h) '.out'];
		[equipos_x, puntaje_y, e, cant] = leer_datos_float(textFileName0);

		hold on;
		%axis([tolerancia_x(1)-0.05,tolerancia_x(length(tolerancia_x))+0.05]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio

		if h == 0.1
			stem(puntaje_y, equipos_x, 'LineStyle', 'none', 'Marker', 'o', '-g');
		elseif h == 0.25
			stem(puntaje_y, equipos_x, 'LineStyle', 'none', 'Marker', 'x', '-b');
		else
			stem(puntaje_y, equipos_x, 'LineStyle', 'none', 'Marker', 'd', '-r');
		end
		xlabel('Equipos','FontSize',12);
		ylabel('Puntaje','FontSize',12);

		legend('C = 0.1','C = 0.25','C = 0.4','Location','southwest');
		hold off;
	end
	textFileName1 = ['graficos/exp3-partidos-liga' num2str(i) '-C'];
	print(textFileName1, filetype);


end