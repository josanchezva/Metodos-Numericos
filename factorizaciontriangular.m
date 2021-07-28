clear;
clc;

%se pide el numero de variarrles o de ecuaciones a resolver
n = input('Ingrese la cantidad de ecuaciones a resolver: ');
fprintf('\n');

%Se define una matriz de ceros para llenarla posteriormente con las
%ecuaciones ingresadas

eqns = sym(zeros(1,n));

%Mediante un ciclo se guardan las ecuaciones ingresadas
for i = 1:n
    %En este ciclo se almacenan las ecuaciones
    fprintf('Por favor inserte la ecuacion numero %u: ', i);
    userInput = input('', 's');
    eqns(i) = str2sym(userInput);  
   
end
fprintf('\n');

%Las ecuaciones se almacenan en una matriz simbólica

[A,b]=equationsToMatrix(eqns);
   
%Definición y lleando de matriz L
L=sym(eye(n,n));

Lext=eye(n,n+1);

for j=1:n
    Lext(j,n+1)=b(j,1);
end

%Se iguala una mtariz U a la matriz inicial A para realizar los calculos
%sin perder los datos de la matriz inicial
U=A;

Uext=eye(n,n+1);
pivote=-1;
disp('La matriz de coeficientes inicial es:')
disp(U);

% 
% for j=1:n
%     for i=1:n
%         if(i==j && U(i,j)==0)
%             disp('No se puede solucionar esta matriz')
%             return
%         end
%     end
% end

disp('Resolviendo las matrices L y U:')

for j=1:n
    for i=1:n
        if(i==j)
            %Define el pivote cuando el iterador de la fila es el mismo de
            %la columna
            pos1=i;
            pos2=j;
            pivote= U(i,j);
            if(pivote==0)
                break;
            end
        end
        if(i>j)
            %Se lleva a 0 lo que está por debajo de la diagonal principal
            %para completar la matriz triangular superior U
            multiplicador=U(i,j)/pivote;
            %El siguiente ciclo evalua toda la fila del iterador actual respecto a la del
            %pivote y realiza los calculos necesarios
            for k=1:n
                U(i,k)=U(i,k)-(multiplicador*(U(pos1,k)));
                disp('L= ');
                disp(L);
                disp('U= ');
                disp(U);
            end
            %Se almacena simultaneamente La matriz L añadiendo los
            %multiplicadores hallados anteriormente
            L(i,j)=multiplicador;
            Lext(i,j)=multiplicador;
        end
    end
end

%Imprime las matrices U y L encontradas finalmente
disp('Las matrices resultantes son:');
fprintf('\n');
disp('L= ');
disp(L);
disp('U= ');
disp(U);


 %Impresión de la Matriz LY=B
disp('Resolviendo LY=B: ');
fprintf('\n');
for i=1:n
    for j=1:n
        if(Lext(i,j)==0)
            fprintf('%11c','0');
        else
            fprintf('%8.0f·y%.0f', Lext(i,j),j);
        end
        
    end
    fprintf('%5c %4.0f\t','=',Lext(i,j+1));
    fprintf('\n');
end
fprintf('\n');

%Cálculo e impresión de la matriz Y
disp('Se obtiene: ')
fprintf('\n');
Y=sustProgresiva(Lext,n);

for i = 1:n
    fprintf('%5c%u: %3.0f\n','y',i,Y(i));
end
fprintf('\n');


for i=1:n
    for j=1:n
        Uext(i,j)= U(i,j);
    end
end
for j=1:n
        Uext(j,n+1)=Y(1,j);
end

%Impresión de la Matriz LY=B
disp('Resolviendo UX=Y: ');
fprintf('\n');
for i=1:n
    for j=1:n
        if(Uext(i,j)==0)
            fprintf('%11c','0');
        else
            fprintf('%8.0f·x%.0f', Uext(i,j),j);
        end
        
    end
    fprintf('%5c %4.0f\t','=',Uext(i,j+1));
    fprintf('\n');
end
fprintf('\n');

%Cálculo e impresión de la matriz X
disp('Finalmente se obtiene: ');
fprintf('\n');
X=sustRegresiva(Uext,n);

for i = 1:n
    fprintf('%5c%u: %3.0f\n','x',i,X(i));
end
fprintf('\n');

%Realiza la sustitución de las variables de la forma progresiva (De arriba hacia abajo) para una
%matriz de tamaño n
function x = sustProgresiva(arr,n)
x = zeros(1,n);
    for i = 1:n
        sum = 0;
        for j = 1:i
            sum = sum + arr(i,j) * x(j);
        end
        x(i) = (arr(i,n+1) - sum) / arr(i,i);
    end
end
%Realiza la sustitución de las variables de la forma progresiva (De abajo hacia arriba) para una
%matriz de tamaño n
function x = sustRegresiva(arr,n)
  for i = n:-1:1
    sum = 0;
    for j = i+1:n
      sum = sum + arr(i,j)*x(j);
    end
    x(i) = (arr(i,n+1)-sum)/arr(i,i);
  end
end