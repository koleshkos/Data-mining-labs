clear all;
close all;
clc;

X = load('data12.txt');
siz = size(X);

X_norm = normalize(X);
R = ((X_norm')*X_norm)/(siz(1)-1); %Матрица
[A,LAMB] = eig(R);
LAMB = rot90(LAMB,2);
d = get_d(R,X)  %проверить значимо ли отличается от единичной матрицы корреляционная матрица исходных нормированных данных
chi2 = chi2inv(0.99,siz(2)*(siz(2)-1)/2)
Z = fliplr(X_norm*A);

sum_disp_Z = sum_var(Z)
sum_disp_X = sum_var(X_norm)
scatter_j = get_scatter_j(Z) % Относительная доля разброса, приходящаяся на j-ую главную компоненту
scatter_i = get_scatter_i(Z) %  Относительная доля разброса, приходящаяся на i первых компонент
covMatrix_Z = (Z'*Z)/(siz(1)-1);
figure(3);
scatter(Z(:,1),Z(:,2),30,'r','filled','o')
xlabel('Z1');
ylabel('Z2');
grid on;



