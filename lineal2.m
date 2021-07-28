clc;
clear;
close all;
disp('Disparo Lineal');
syms t;

funstr='(2*t)/(1+t^2)';
P = str2func( ['@(t,x,y)' funstr ] );
funstr='-2/(1+t^2)';
Q = str2func( ['@(t,x,y)' funstr ] );
funstr='1';
R = str2func( ['@(t,x,y)' funstr ] );
a=0;
x_a=1.25;
b=4;
x_b=-0.95;
h=0.2;
syms x y;
X2=P*y+Q*x+R;
X2=matlabFunction(X2);

U2=P*y+Q*x+R;

U2=matlabFunction(U2);
V2=P*y+Q*x;

V2=matlabFunction(V2);

Uk=Rk(U2,a,b,x_a,h);



