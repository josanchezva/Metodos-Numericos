%function y = minimos_cuadrados(~)
    clear;
    clc;
    close all;
    
    %Encapsulamiento de datos
    % Se almacenan las coordenadas y se separan las X y las Y
    inputMatrix = input('Ingrese las coordenadas. (Usar formato Matlab ej: [1 2; 3 4; 5 6]) \n');
    inputX=inputMatrix(:,1);
    inputY=inputMatrix(:,2);
    [m,n] = size(inputMatrix);
    
    syms x;
    f = x^2;
    %calculo de las coordenadas elvadas al cuadrado
    X2_k = subs(f, x, inputX);
    
    XY=[m];
    for i=1:m
        XY(i)=inputX(i)*inputY(i);
    end
    
    %sumatorias
    sumX = sum(inputX);
    sumY = sum(inputY);
    sumX2_k = double(sum(X2_k));
    sumXY = sum(XY);
    
    %Sistema de ecuaciones lineales 
    
    %Se generan las ecuaciones
    syms A B;
    eqn1 = sumX2_k*A+sumX*B== sumXY;
    eqn2 = sumX*A+m*B== sumY;
    
    %Se convierten las ecuaciones a matriz de coeficientes
    [coeficientes,resultados]=equationsToMatrix([eqn1, eqn2], [A,B]);
    
    %La función linsolve retorna una matriz con los resultados de las
    %ecuaciones
    C=vpa(linsolve(coeficientes,resultados));
    
    %Impresión de la tabla
    fprintf('_______________________________________________\n');
    fprintf('     Xk         Yk         Xk^2      XkYk\n');
    fprintf('_______________________________________________\n');
    
    for i=1:m
    fprintf('%10.5f %10.5f %10.5f %10.5f\n',inputX(i), inputY(i),X2_k(i),XY(i));     
    end
    fprintf('_______________________________________________\n');
    fprintf('%10.5f %10.5f %10.5f %10.5f\n',sumX,sumY,sumX2_k,sumXY);
    fprintf('_______________________________________________\n\n');
    
    %Impresión sistema de ecuaciones
    disp('El sistema de ecuaciones resulta ser:')
    
    disp(eqn1);
    disp(eqn2);
    %----------------------------------
    %Se organizan los datos hallados en una recta
    digits(8);
        y=vpa(C(1))*x+vpa(C(2));
    disp('La función resultantes es: ')
    disp(y);
    
    
    %Impresión de la gráfica
    hold on
    ax = gca;
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    title('Rectas de regresión en mínimos cuadrados')
    xlabel('X') 
    ylabel('Y') 
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    fplot(y)
    scatter(inputX,inputY);
    
    hold off
    %------------------------
%end