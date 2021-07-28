clear;
clc;
close all;

%Preguntamos al usuario los limites del campo vectorial:
fprintf("A continuacion ingresa los limites del campo vectorial.\n");
fprintf("\n");

fprintf('Ingresa los limites del eje "y": \n');
fprintf("\n");

campyi = input('Limite inferior: ');
campyf = input('Limite superior: ');
fprintf("\n");

fprintf('Ingresa los limites del eje "x": \n');
fprintf("\n");

campxi = input('Limite inferior: ');
campxf = input('Limite superior: ');
fprintf("\n");

%intCampo=input('Intervalo del campo vectorial:\n Ej=[0 2; 0 2] [x x;y y]\n');
intCampo=[campxi campxf;campyi campyf];
[a,b] = meshgrid(intCampo(1,1):0.2:intCampo(1,2),intCampo(2,1):0.2:intCampo(2,2));

%Se pregunta las funciones del campo vectorial:
fprintf('¿Cuál es la funcion de la componente "x" del campo vectorial? \n');
userInput = input('u(x,y) >> ','s');
funstr1 = insertBefore(userInput,"*",".");
funstr2 = insertBefore(funstr1,"/",".");
funstr3 = insertBefore(funstr2,"^",".");
i=str2func(['@(t,x,y)',funstr3]);

u=i(1,a,b);
fprintf("\n");

fprintf('¿Cuál es la funcion de la componente "y" del campo vectorial? \n');
userInput = input('v(x,y) >> ','s');
funstr1 = insertBefore(userInput,"*",".");
funstr2 = insertBefore(funstr1,"/",".");
funstr3 = insertBefore(funstr2,"^",".");
j=str2func(['@(t,x,y)',funstr3]);
v=j(1,a,b);
fprintf("\n");

%Preguntamos el tiempo de simulacion: 
tiempo = input('¿Tiempo de simulación?: ');
fprintf("\n");

%Creamos un arreglo con las unidades de tiempo:
intTrayectoria=[0 tiempo];

%Preguntamos al usuario el inveralo: 
h= input('Ingrese el tamaño del intervalo "h": ');
fprintf("\n");

%Se crean todos los pasos a calcular:
t=(intTrayectoria(1):h:intTrayectoria(2));

%Preguntamos las condiciones iniciales i.e., la posicion de la particula. 
fprintf('A continuacion, ingrese la posicion incial de la partícula: \n');
fprintf("\n");

x0 = input('Posicion inicial en la componente "x": ');
y0 = input('Posicion inicial en la componente "y": ');
fprintf("\n");
fprintf("\n");

%Creamos el arreglo con la posicion inicial:
P = [x0;y0];

%Llevamos a cabo el metodo de Euler para compararlo despues con RK4:
[x2,y2] = RK4_SED(t,i,j,h,length(t) - 1,P(1),P(2));

%Llevamos a cabo el metodo de RK4 el cual retorna dos vectores:
[x1,y1] = Euler(t,i,j,h,length(t) - 1,P(1),P(2));

%Imprimimos la tabla con todas las posiciones correspondientes:
fprintf("%19s | %19s | %6s\n","Euler","RK4","Tiempo");
fprintf("%9s %9s | %9s %9s | %6s\n","x","y","x","y","t");

for i = 1:length(t)
    %Euler
    x1i = x1(i);
    y1i = y1(i);
    
    %RK4
    x2i = x2(i);
    y2i = y2(i);
    
    %Tiempo
    ti = t(i);
    
    fprintf("%9.5f %9.5f | %9.5f %9.5f | %6.2f\n",x1i,y1i,x2i,y2i,ti);
end
fprintf("\n");

%Imprimimos la coordenada final:
fprintf("Coordenada de llegada despues de %i unidades de tiempo usando RK4: \n", tiempo);
fprintf("( %10.7f, %10.7f )\n",x2i,y2i);

fprintf("Coordenada de llegada despues de %i unidades de tiempo usando Euler: \n", tiempo);
fprintf("( %10.7f, %10.7f )\n",x1i,y1i);

set(gcf, 'Position',  [320, 180, 1280, 720])

%Graficamos Euler
axis on;

subplot(1,2,2);

hold on;

pt1 = plot(x1,y1,'-o');
pt1.MarkerSize = 3.5;
pt1.Color = '#1F1300';

pt2 = plot(x1(1),y1(1),'-o');
pt2.MarkerSize = 20;
pt2.Color = '#A31621';

pt3 = plot(x1(length(x1)),y1(length(y1)),'-x');
pt3.MarkerSize = 20;
pt3.Color = '#A31621';

quiver(a,b,u,v,'color',[0.30588 0.50196 0.59608]);

pbaspect([1 1 1]);

title("Euler Method");

hold off;

%Graficamos RK4
axis on;

subplot(1,2,1);

hold on;

pe1 = plot(x2,y2,'-o');
pe1.MarkerSize = 3.5;
pe1.Color = '#1F1300';

pe2 = plot(x2(1),y2(1),'-o');
pe2.MarkerSize = 20;
pe2.Color = '#A31621';

pe3 = plot(x2(length(x2)),y2(length(y2)),'-x');
pe3.MarkerSize = 20;
pe3.Color = '#A31621';

quiver(a,b,u,v,'color',[0.30588 0.50196 0.59608]);

pbaspect([1 1 1]);

title("Runge-Kutta 4");

hold off;


