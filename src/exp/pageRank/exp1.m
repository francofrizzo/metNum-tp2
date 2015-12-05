function exp1()
    filetype='-dpdf';
    mkdir('graficos');
    figure;
    set(gca,'FontName', 'FreeSans');

    % Gráfico Etapa A

    [x, y, e, cant] = leer_datos('exp1/exp1-a-times.txt');

    hold on;
    errorbar(x, y, e);
    axis([x(1)-0.05,x(length(x))+0.05]); % esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
    xlabel('Cantidad de nodos','FontSize',12);
    ylabel('Tiempo de ejecucion en ciclos de clock','FontSize',12);
    hold off;
    print('graficos/exp1-a', filetype);
    cla;

    % Gráfico Etapa B

    [x, y, e, cant] = leer_datos('exp1/exp1-b-times.txt');

    hold on;
    errorbar(x, y, e);
    axis([x(1)-0.05,x(length(x))+0.05]); % esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
    xlabel('Cantidad de enlaces','FontSize',12);
    ylabel('Tiempo de ejecucion en ciclos de clock','FontSize',12);
    hold off;
    print('graficos/exp1-b', filetype);