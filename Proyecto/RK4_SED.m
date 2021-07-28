function [Xj, Yj]= RK4_SED(t_j,X1,Y1, h , m , val_inX,val_inY)
%t_j: Matriz de los puntos t a evaluar 
%inicialización de matrices donde se guardarán los pasos intermedios f1-f4 y g1-g4
    f = zeros(4,1);
    g = zeros(4,1);
%inicialización de matrices donde se guardarán los resultados de los puntos x, y del algoritmo   
    Xj = zeros(m,1);
    Yj = zeros(m,1);
    
    Xj(1,1)=val_inX;
    Yj(1,1)=val_inY;
  
    for i=1:m
        
        
        f(1) = X1(t_j(i), Xj(i), Yj(i));
        g(1) = Y1(t_j(i), Xj(i), Yj(i));
        
        f(2) = X1(t_j(i) + h/2, Xj(i) + h/2*f(1), Yj(i) + h/2*g(1));
        g(2) = Y1(t_j(i) + h/2, Xj(i) + h/2*f(1), Yj(i) + h/2*g(1));
        
        f(3) = X1(t_j(i) + h/2, Xj(i) + h/2*f(2), Yj(i) + h/2*g(2));
        g(3) = Y1(t_j(i) + h/2, Xj(i) + h/2*f(2), Yj(i) + h/2*g(2));
        
        f(4) = X1(t_j(i) + h, Xj(i) + h*f(3), Yj(i) + h*g(3));
        g(4) = Y1(t_j(i) + h, Xj(i) + h*f(3), Yj(i) + h*g(3));
        
        Xj(i+1) = Xj(i) + (h*(f(1)+2*f(2)+2*f(3)+f(4)))/6;
        Yj(i+1) = Yj(i) + (h*(g(1)+2*g(2)+2*g(3)+g(4)))/6;
        
        %descomentar las impresiones si se busca imprimir todos los pasos
        %del algoritmno
        %fprintf('t(%i)=%f x(%i)=%f y(%i)=%f\n',i,t_j(i),i,Xj(i),i,Yj(i));
        %fprintf('f1=%f f2=%f f3=%f f4=%f\n g1=%f g2=%f g3=%f g4=%f\n x(%i)=%f y(%i)=%f\n\n',f(1),f(2),f(3),f(4),g(1),g(2),g(3),g(4),i+1,Xj(i+1),i+1,Yj(i+1));
    end
end