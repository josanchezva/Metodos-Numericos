clc;
clear;
close all;

%intCampo=input('Intervalo del campo vectorial:\n Ej=[0 2; 0 2] [x x;y y]\n');
intCampo=[-5 5;-5 5];
[a,b] = meshgrid(intCampo(1,1):0.2:intCampo(1,2),intCampo(2,1):0.2:intCampo(2,2));

%funstr = input('¿Cuál es su componente i del campo vectorial? \n','s');
funstr = '-y';
i=str2func(['@(t,x,y)',funstr]);
u=i(1,a,b);

%funstr = input('¿Cuál es su componente j del campo vectorial? \n','s');
funstr = 'x';
j=str2func(['@(t,x,y)',funstr]);
v=j(1,a,b);

%u = cos(a+b).*b+b;
%v = sin(a+b).*b+b;

%tiempo= input('Tiempo de simulación?:\n \n');
tiempo=5;
intTrayectoria=[0 tiempo];
%h= input('Intervalo de salto (h):\n');
h=0.1;
t=(intTrayectoria(1):h:intTrayectoria(2));
%x0 = [0; 0];

%x0= input('Velocidad incial de la partícula:\nEj=[0 2] [x ; y]\n');
x0 = [-1.5;-3];

%[t, y] = ode23(@odefun,t,x0);

figure
%plot(t,y);

[x,y]=RK4_SED(t,i,j,h,length(t),x0(1),x0(2));

hold on
plot(x,y,'->');
p=plot(x(1),y(1),'-o');
p.MarkerSize=20;
c=plot(x(length(x)),y(length(y)),'-x');
c.MarkerSize=20;
%plot(y(:,1),y(:,2));
quiver(a,b,u,v);
hold off

function y = odefun(t,x)
    %u = cos(a).*b;
    %v = sin(a).*b;
    %y=zeros(2,1);
    %y(1,1) = i(x(1),x(2));
    y(1,1) = cos(x(1)) .* x(2);       % u(x, y)
    y(2,1) = sin(x(1)) .* x(2);       % v(x, y)
    fprintf('x(1)=%f, x(2)=%f , y(1,1)=%f ,y(2,1)=%f\n',x(1),x(2),y(1,1),y(2,1)) 
end


