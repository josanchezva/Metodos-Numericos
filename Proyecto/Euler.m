% Se piden los datos necesarios para realizar el método de Euler en un sistema 
% de acuaciones diferenciales los cuales son, el intervalo, las dos funciones,
% el paso, y las coordenadas del punto inicial.

function [Xj, Yj] = Euler(t, X1, Y1, h, m, val_inX,val_inY)

    %Inicializamos las matrices respuesta
    Xj = zeros(m,1);
    Yj = zeros(m,1);
    
    %Ubicamos las coordenadas iniciales en las matrices respuesta
    Xj(1,1)=val_inX;
    Yj(1,1)=val_inY;
    
    %Implementar el método y resolver el sistema de ecuaciones
    for i=1:m
        Xj(i+1)=Xj(i)+h*X1(t,Xj(i),Yj(i));
        Yj(i+1)=Yj(i)+h*Y1(t,Xj(i),Yj(i));  
    end
 