close all;
clear all;
clc;

a = -5;
b = 5;

X = a:0.1:b;
Y = a:0.1:b;
[X,Y] = meshgrid(X,Y);

figure(1)
mesh(X,Y,F(X,Y));

figure(2)
surface(X,Y,F(X,Y));

N = 100000;
[c,value] = st_search(N)

T0 = 1e-10;
T = 275;
v = 0.99;
X0 = [rand(1);rand(1)];
[c,value] = annealing(T0,T,v,X0)
