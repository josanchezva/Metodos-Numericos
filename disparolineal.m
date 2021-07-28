clc;
clear;
close all;
disp('Disparo Lineal');

flag = input('Ingrese 1 si tiene una función para comparar, si no presione 0\n');
%flag=1;
if flag==1
    funstr = input('¿Cuál es su funcion? \n','s');
    %funstr = '1.25+0.4860896526*t-2.25*t^2+2*t*atan(t)+1/2*(t^2-1)*log(1+t^2)';
    funcion = strcat("@(t)", funstr);
    funcion = str2func(funcion);
end


P_funstr = input('¿Cuál es su funcion P? \n','s');
%P_funstr = '(2*t)/(1+t^2)';
P= str2func( ['@(t)' P_funstr ] );


Q_funstr = input('¿Cuál es su funcion Q? \n','s');
%Q_funstr = '-2/(1+t^2)';
Q= str2func( ['@(t)' Q_funstr ] );

R_funstr = input('¿Cuál es su funcion R? \n','s');
%R_funstr = '1';
R = str2func( ['@(t)' R_funstr ] );

int=input('ingrese el intervalo. (ej [0 4])\n');
%int = [0 4];

alpha= input("Ingrese x("+int(1)+")=");
%alpha = 1.25;
beta= input("Ingrese x("+int(2)+")=");
%beta = -0.95;

h= input("Ingrese el salto h de las aproximaciones:\n");
%h=0.2;
Tj = int(1):h:int(2);
m = (int(2)-int(1))/h;
%construcciones ecuaciones de impresion
syms x y;
X2=P*y+Q*x+R;
U2=P*y+Q*x+R;
V2=P*y+Q*x;
fprintf('**********************************\n')
fprintf('Valores Ingresados:\n\n');
fprintf('X2=%s\n',X2);
fprintf('x(%.2f) = %f | x(%.2f) = %f | h=%f\n\n',int(1),alpha,int(2),beta,h);
fprintf('**********************************\n')
fprintf('Construyendo las funciones U y V se obtiene\n');
fprintf('U2=%s\n',U2);
fprintf('x(%.2f) = %f | y(%.2f) = %f | h=%f\n\n',int(1),alpha,int(1),0,h);
fprintf('V2=%s\n',V2);
fprintf('x(%.2f) = %f | y(%.2f) = %f | h=%f\n\n',int(1),0,int(1),1,h);
fprintf('**********************************\n')

%Construccion de ecuaciones 

%Ecuacion U y solucion con RK4
f=@(t,x,y) y;
g=matlabFunction(U2);

Uj = RK4_SED(Tj,f,g,h,m,alpha,0);

%Ecuacion U y solucion con RK4
g=matlabFunction(V2);

Vj = RK4_SED(Tj,f,g,h,m,0,1);

Wj=((beta - Uj(m+1)) / (Vj(m+1)))*Vj;

Xj=Uj+Wj;

%Segun la decision tomada de usar una solucion exacta se muestra una tabla
%de 4 o 2 columnas
if flag==1
    tipos = {'double','double','double','double'};
    titulo_columnas ={'Tj','Xj','x(Tj) exacto','x(Tj)-Xj error'};
    tabla= table('Size',[0 4], 'Variabletypes', tipos,'VariableNames',titulo_columnas);

    for i=1:m+1
        tabla(i,:)={Tj(i),Xj(i), funcion(Tj(i)), abs(funcion(Tj(i))-Xj(i))};
    end
    fprintf("Con h="+ h+"\n");
    disp(tabla);

else
    tipos = {'double','double'};
    titulo_columnas ={'Tj','Xj'};
    tabla= table('Size',[0 2], 'Variabletypes', tipos,'VariableNames',titulo_columnas);

    for i=1:m+1
        tabla(i,:)={Tj(i),Xj(i)};
    end
    fprintf("Utilizando h="+ h+"\n");
    disp(tabla);

end
%Grafico de las aproximaciones resultantes
hold on;
xlabel('t')
ylabel('y')
plot(Tj,Uj, '-*');
plot(Tj,Vj, '-*');
plot(Tj,Xj, '-*');
legend({'U(t)','V(t)','X(t)'});
hold off;




