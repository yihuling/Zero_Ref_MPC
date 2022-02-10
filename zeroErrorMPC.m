function [M,C,Q_bar,R_bar,G,H,E,U] = zeroErrorMPC(A,B,N,x_k,Q,R,F)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
n = size(A,1);
p = size(B,2);
M = [eye(n);zeros(N*n,n)];
C = zeros((N+1)*n,N*p);
temp = eye(n);
%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    C(i*n+(1:n),:) = [temp * B , C((i-1)*n+(1:n),1:(N*p-p))];
    temp = A * temp;
    M(i*n+(1:n),:) = temp;
end
%%%%%%%%%%%%%%%%%%%%%%%%
s_Q = size(Q,1);
s_R = size(R,1);
Q_bar = zeros((N+1)*s_Q,(N+1)*s_Q);
R_bar = zeros(N*s_R,N*s_R);
for i=0:N-1
    Q_bar(i*s_Q+(1:s_Q),i*s_Q+(1:s_Q)) = Q;
end
Q_bar(N*s_Q+(1:s_Q),N*s_Q+(1:s_Q)) = F;

for i=0:N-1
    R_bar(i*s_R+(1:s_R),i*s_R+(1:s_R)) = R;
end
G = M'*Q_bar*M;
H = C'*Q_bar*C + R_bar;
E = M'*Q_bar*C;
%%%%%%%%%%%%%%%%%%%%%%%
f = (x_k'*E)';
U = quadprog(H,f);
end

