clear;
clc;
close all;

syms x;

%Solicitud de la variable
funstr = input('¿Cuál es su función?: ','s');
    
%Pasar cadena a una función
f = str2func( ['@(x)' funstr ] );
%Intervalo Izquierdo
a = input('Valor de a (intervalo izquierdo): ');
%Intervalo Derecho    
b = input('Valor de b (intervalo derecho): ');

cantNodos = input('¿Cantidad de Nodos?: ');
%Calculo real de nodos
M=cantNodos-1;
M=M/2;
%calculo de espaciado
h=(b-a)/(2*M);
disp('****************************************************************')
fprintf('\nPara %i nodos se halló un espacio de h=%f entre los nodos\n',cantNodos,h);
%cálculo de los valores iniciales antes de la sumatoria, los valores
%extremos
T=(h/3)*(f(a)+f(b));

sum=0;
Xk=a;
fprintf('\nS=(f,%.5f)= %.5f(f(%.5f)+f(%.5f))+%f(',h,h/3,a,b,2/3*h);
%mediante un ciclo se calcula la primera sumatoria de la funcion, en esta
%parte se utiliza las iteraciones pares para corresponder con la función
for i=1:2*M-1
    Xk=Xk+h;
    if mod(i,2)==0
        sum=sum+f(Xk);
        if(i== 2*M-2)
            fprintf('%s%4.5f%s','f(',Xk,'))');
        else
            fprintf('%s%4.5f%s+','f(',Xk,')');
        end
    end
end
sum= 2/3*h*sum;
T=T+sum;

fprintf('+%f(',4/3*h);

sum=0;
Xk=a;
%mediante un ciclo se calcula la segunda sumatoria de la funcion, en esta
%parte se utiliza las iteraciones impares para corresponder con la función
for i=1:2*M
    Xk=Xk+h;
    if mod(i,2)~=0
        sum=sum+f(Xk);
        if(i== 2*M-1)
            fprintf('%s%4.5f%s','f(',Xk,'))');
        else
            fprintf('%s%4.5f%s+','f(',Xk,')');
        end
    end    
end
sum= 4/3*h*sum;
T=T+sum;

%***************************************************************
%sección de impresion
%En esta sección se hace el mismo proceso anterior para mostrar el paso a
%paso de la solución
sum=0;
Xk=a;
fprintf('\n\nS=(f,%.5f)= %.5f(%.5f+%.5f)+%f(',h,h/3,a,b,2/3*h);
for i=1:2*M-1
    Xk=Xk+h;
    if mod(i,2)==0
        sum=sum+f(Xk);
        if(i== 2*M-2)
            fprintf('%s%4.5f%s','(',f(Xk),'))');
        else
            fprintf('%s%4.5f%s+','(',f(Xk),')');
        end
    end
end

fprintf('+%f(',4/3*h);

sum=0;
Xk=a;
for i=1:2*M
    Xk=Xk+h;
    if mod(i,2)~=0
        if(i== 2*M-1)
            fprintf('%s%4.5f%s','',f(Xk),'))');
        else
            fprintf('%s%4.5f%s+','',f(Xk),')');
        end
    end    
end


%El resultado final se alamacena en la variable T y aquí se imprime
fprintf('\n\nS=(f,%f)=%.10f\n',h,T);

