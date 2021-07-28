clc;
clear;
close all;

t_j = 0:0.2:4;
m = (4-0)/0.2;

P_funstr='(2*t)/(1+t^2)';
Q_funstr='-2/(1+t^2)';
R_funstr='1';
f=@(t,x,y) y;
g=strcat("@(t,x,y) ", P_funstr + "*y + ", Q_funstr + "*x + "+R_funstr);
g=str2func(g);


u_j = RK4_SED(t_j,f,g,0.2,m,1.25,0);