
clear;
clc;
close all;
%Solicitud de la función

funstr = input('¿Cuál es su funcion? ','s');
y= str2func( ['@(x)' funstr ] );

%se pide el numero de nodos 
n = input('Ingrese la cantidad de nodos en el intervalo: ');
fprintf('\n')
nodos = zeros(1,n);
nodos2 = zeros(1,n);
coeficientes = zeros(1,n);

%Mediante un ciclo se guardan los nodos ingresadas
disp('Conjunto de nodos: ');
for i = 1:n
    fprintf('Por favor inserte el nodo numero %u: ', i);
    userInput = input('');
    nodos(i)= userInput;
end
%se almacenan los puntos de las ordenadas para la función
%ingresada (coeficientes)
for i=1:n
    coeficientes(i)=y(nodos(i));
end

%calculo de denominadores
res=1;
aux=1;
for i=1:n
    for j=1:n
        if(i~=j)
            %itera los nodos ingresados para hallar los denominadores
            aux=(nodos(i)-nodos(j));
            res=res*aux;
        end
    end
    %almacena cada iteración sobre la función
    coeficientes(i)=coeficientes(i)/res;
    res=1;
end


%Calculo de la productoria

arrayEquations = sym(vpa(coeficientes));
productoria=sym(zeros(1,n));
syms x;
aux2= sym('1'); 
for i=1:n
    for j=1:n
        if(i~=j)
            %se almacena la productoria y le hace un formateo para
            %mostrarlo en decimal
            aux2=aux2*(x-nodos(j));
        end
    end
    productoria(i)=vpa(aux2);
    arrayEquations(i)=sym(arrayEquations(i)*aux2);
    
    aux2= sym('1');
end
P=@(x)(0);


for i=1:n
    P=P+arrayEquations(i);
end

%**************************************************


fprintf('¿Desea comparar utilizando otros nodos? 1.si 2.no ');
userInput = input('');

%ejecuta una nueva comparación para la nueva función si así se decidió
if(userInput ==1 )
    disp('Segundo conjunto de nodos:');
    for i = 1:n
        fprintf('Por favor inserte el nodo numero %u: ', i);
        userInput = input('');
        nodos2(i)= userInput;
    end
    coeficientes2=zeros(1,n);
    for i=1:n
        coeficientes2(i)=y(nodos2(i));
    end
    res=1;
    aux=1;
    for i=1:n
        for j=1:n
            if(i~=j)
                aux=(nodos2(i)-nodos2(j));
                res=res*aux;
            end
        end
        coeficientes2(i)=coeficientes2(i)/res;
        res=1;
    end
    arrayEquations2 = sym(vpa(coeficientes2));
    productoria2=sym(zeros(1,n));
    syms x;
    aux2= sym('1'); 
    for i=1:n
        for j=1:n
            if(i~=j)
                aux2=aux2*(x-nodos2(j));
            end
        end
        productoria2(i)=vpa(aux2);
        arrayEquations2(i)=sym(arrayEquations2(i)*aux2);

        aux2= sym('1');
    end
    Q=0;

    for i=1:n
        Q=Q+arrayEquations2(i);
    end
else 
end

%*****************************************************************************************  
%Sección de impresión en consola

fprintf('*****************************************************************************************')
fprintf('\nDatos ingresados:\n')
fprintf('y=%s\n',funstr);
if(userInput==1)
    fprintf('Primer conjunto de nodos: ')
    fprintf('[ ')
    %imprime nodos seleccionados en el primer conjunto
    for i=1:n
        fprintf('%.2f ',nodos(i));
    end
    fprintf(']\n')
    %imprime nodos seleccionados en el segundo conjunto
    
    fprintf('Segundo conjunto de nodos ')
    fprintf('[ ')
    for i=1:n
        fprintf('%.2f ',nodos2(i));
    end
    fprintf(']\n\n')
    
    fprintf('Datos de salida:\n')
    %Imprime el polinomio P hallada
    fprintf('P= ');
    for i=1:n
       if(i<n+1 && i>1 && coeficientes(i)> 0)
           fprintf('+');
       end
       fprintf('%f*(%s)',coeficientes(i), productoria(i));
       
    end
    
    %Imprime el polinomio Q hallada
    
    fprintf('\nQ= ');
    for i=1:n
       if(i<n+1 && i>1 && coeficientes2(i)> 0)
           fprintf('+');
       end
       fprintf('%f*(%s)',coeficientes2(i), productoria2(i));
       
    end
    
    
    %Impresion de la tabla
    h = (nodos(n)-nodos(1))/0.1;
    xk = [h];
    
     
    fprintf('\n\nTabla de valores: ');
    
    j=1;
    fprintf('\n Xk      F(Xk)      P*(Xk)    F(Xk)-P(Xk)    Q(Xk)    F(Xk)-Q(Xk)\n');
    fprintf('___________________________________________________________________')
    
    Paux=matlabFunction(P);
    Qaux=matlabFunction(Q);
    for i=0:0.1:nodos(n)
       xk(j)=i;
       j=j+1;
       fp=y(i)-Paux(i);
       fq=y(i)-Qaux(i);
       fprintf('\n');
       fprintf('%0.1f %11.6f %11.6f %11.6f %11.6f %11.6f\n',i,y(i),Paux(i),fp,Qaux(i),fq);
    end
    
    %gráfico de los polinomios y función inicial
    hold on
    ax = gca;
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    title('Interpolación de Lagrange')
    xlabel('X') 
    ylabel('Y')
    fplot(P)
    fplot(Q)
    fplot(y)
    legend({'P1','Q1',funstr},'Location','northeast')
    hold off
    
    
elseif(userInput==2)
    
    %imprime nodos seleccionados en el primer conjunto
    fprintf('Primer conjunto de nodos: ')
    fprintf('[ ')
    
    for i=1:n
        fprintf('%.2f ',nodos(i));
    end
    fprintf(']\n\n')
    fprintf('Datos de salida:\n')
    fprintf('P= ');
    for i=1:n
       if(i<n+1 && i>1 && coeficientes(i)> 0)
           fprintf('+');
       end
       fprintf('%f*(%s)',coeficientes(i), productoria(i));
    end
    fprintf('\n');
    
    
    %Impresion de la tabla
    h = (nodos(n)-nodos(1))/0.1;
    xk = [h];
    
     
    fprintf('\nTabla de valores: ');
    
    j=1;
    fprintf('\n Xk      F(Xk)      P*(Xk)    F(Xk)-P(Xk)\n');
    fprintf('___________________________________________')
    Paux=matlabFunction(P);
    for i=0:0.1:nodos(n)
       xk(j)=i;
       j=j+1;
       fp=y(i)-Paux(i);
       fprintf('\n');
       fprintf('%0.1f %11.6f %11.6f %11.6f\n',i,y(i),Paux(i),fp);
    end
    
    hold on
    ax = gca;
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    title('Interpolación de Lagrange')
    xlabel('X') 
    ylabel('Y') 
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    fplot(P)
    fplot(y)
    legend({'P1',funstr},'Location','northeast')
    hold off
end