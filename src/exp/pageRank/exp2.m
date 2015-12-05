function exp2()
    filetype='-dpdf';
    mkdir('graficos');
    figure;
    set(gca,'FontName', 'FreeSans');
    set(gca, 'YScale', 'log');

    % Gráfico instancia A

    [x1, y1] = leer_datos_converg('exp2/exp2-a-0.85-converg.txt');
    [x2, y2] = leer_datos_converg('exp2/exp2-a-0.90-converg.txt');
    [x3, y3] = leer_datos_converg('exp2/exp2-a-0.95-converg.txt');
    [x4, y4] = leer_datos_converg('exp2/exp2-a-0.99-converg.txt');

    hold on;
    plot(x1, y1, 'b-o');
    plot(x2, y2, 'g-x');
    plot(x3, y3, 'r-d');
    plot(x4, y4, 'm-s');
    axis([x4(1)-0.05,x4(length(x4))+0.05]); % esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
    xlabel('Numero de iteracion','FontSize',12);
    ylabel('Distancia con el resultado de la iteracion anterior','FontSize',12);
    hold off;
    print('graficos/exp2-a', filetype);
    cla;

    % Gráfico instancia B

    [x1, y1] = leer_datos_converg('exp2/exp2-b-0.85-converg.txt');
    [x2, y2] = leer_datos_converg('exp2/exp2-b-0.90-converg.txt');
    [x3, y3] = leer_datos_converg('exp2/exp2-b-0.95-converg.txt');
    [x4, y4] = leer_datos_converg('exp2/exp2-b-0.99-converg.txt');

    hold on;
    plot(x1, y1, 'b-o');
    plot(x2, y2, 'g-x');
    plot(x3, y3, 'r-d');
    plot(x4, y4, 'm-s');
    axis([x4(1)-0.05,x4(length(x4))+0.05]); % esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
    xlabel('Numero de iteracion','FontSize',12);
    ylabel('Distancia con el resultado de la iteracion anterior','FontSize',12);
    hold off;
    print('graficos/exp2-b', filetype);
    cla;

    % Gráfico instancia C

    [x1, y1] = leer_datos_converg('exp2/exp2-c-0.85-converg.txt');
    [x2, y2] = leer_datos_converg('exp2/exp2-c-0.90-converg.txt');
    [x3, y3] = leer_datos_converg('exp2/exp2-c-0.95-converg.txt');
    [x4, y4] = leer_datos_converg('exp2/exp2-c-0.99-converg.txt');

    hold on;
    plot(x1, y1, 'b-o');
    plot(x2, y2, 'g-x');
    plot(x3, y3, 'r-d');
    plot(x4, y4, 'm-s');
    axis([x4(1)-0.05,x4(length(x4))+0.05]); % esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
    xlabel('Numero de iteracion','FontSize',12);
    ylabel('Distancia con el resultado de la iteracion anterior','FontSize',12);
    hold off;
    print('graficos/exp2-c', filetype);
    cla;

end

function [x, y] = leer_datos_converg(file)
    data = fopen(file);
    y = (fscanf(data, '%f', [1 Inf]))';
    x = (0:(size(y)(1) - 1))';

end
