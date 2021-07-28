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
%calculo de espaciado
h=(b-a)/M;
disp('****************************************************************')
fprintf('\nPara %i nodos se halló un espacio de h=%f entre los nodos\n',cantNodos,h);
%cálculo de los valores iniciales antes de la sumatoria, los valores
%extremos
T=h/2*(f(a)+f(b));

sum=0;
Xk=a;
arrf=[];
fprintf('\nT=(f,%.5f)= %.5f(f(%.5f)+f(%.5f))+%f(',h,h/2,a,b,h);
%mediante un ciclo se calcula la sumatoria de la funcion y se almacenan los
%diferentes resultados en un arreglo para imprimir posteriormente
for i =1:M-1
    Xk=Xk+h;
    sum=sum+f(Xk);
    arrf(i)=(f(Xk));
    if(i== M-1)
        fprintf('%s%4.5f%s','f(',Xk,'))');
    else
        fprintf('%s%4.5f%s+','f(',Xk,')');
    end
    
end
fprintf('\n\nT=(f,%.5f)= %f((%f)+(%f))+%f(',h,h/2,f(a),f(b),h);
Xk=a;
for i =1:M-1
    
    if(i==M-1)
        fprintf('(%4.5f))',arrf(i));
    else
        fprintf('(%4.5f)+',arrf(i));
    end
    
end
sum= h*sum;
T=T+sum;
%El resultado final se alamacena en la variable T y aquí se imprime
fprintf('\n\nT=(f,%f)=%.10f\n',h,T);
