clc;
clear;
A = [1,0.1;0,2];
B = [0;0.5]
N = 3;
x_k = [5;5];
Q = [1,0;0,1];
R = 0.1;
F = [1,0;0,1];
[M,C,Q_bar,R_bar,G,H,E,U] = zeroErrorMPC(A,B,N,x_k,Q,R,F)
