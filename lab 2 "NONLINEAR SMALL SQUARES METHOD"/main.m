clear all;
close all;
clc;

data = load('data12.txt');
xk = data(:,1);
yk = data(:,2);
sdk = data(:,3);
k_var = 100;

% normal distribution
beta = [1;1];
[coeff1,r,J,cov_matrix] = nlinfit(xk, yk, @normal_dist, beta); %оптимизация
los_norm = loss(xk,yk,coeff1,sdk,@normal_dist)
Y = normal_dist(coeff1,xk);
Rk = taken_balance_chart(xk,yk,coeff1,sdk,@normal_dist);
Ak = auto_correlation(Rk,k_var);
auto_conf_intervals_1 = nlparci(coeff1,r,'covar',cov_matrix,'alpha',0.32)
me_conf_intefvals_1 = get_intervals(coeff1,cov_matrix,68)

%figure(1);
%grath(xk,Rk,'Взвешаные остатки','x','Rk');
%figure(2);
%grath(0:k_var-1,Ak,['Автокорелиционная функция'],'k','Ak');
%figure(3);
%grath(xk,yk,'Нормальное распределение','x','f');
hold on;
% plot(xk,Y);
legend('y','f(x,teta)');
format = 'Loss = %3.4f';
str = sprintf(format,los_norm);
text(0.1,0.2,str);
hold off;

% chi-square distribution
beta = [1]; %начальная точка апроксимации
[coeff2,r,J,cov_matrix] = nlinfit(xk, yk, @chi_dist, beta);
los_chi = loss(xk,yk,coeff2,sdk,@chi_dist)
Y = chi_dist(coeff2,xk);
Rk = taken_balance_chart(xk,yk,coeff2,sdk,@chi_dist);
Ak = auto_correlation(Rk,k_var);
auto_conf_intervals_2 = nlparci(coeff2,r,'covar',cov_matrix,'alpha',0.32)
me_conf_intefvals_2 = get_intervals(coeff2,cov_matrix,68) % доверительный интервал

%figure(4);
%grath(xk,Rk,'Взвешаные остатки','x','Rk');
%figure(5);
%grath(0:k_var-1,Ak,['Автокорелиционная функция'],'k','Ak');
%figure(6);
%grath(xk,yk,'Распределение X2','x','f');
hold on;
% plot(xk,Y);
legend('y','f(x,teta)');
format = 'Loss = %3.4f';
str = sprintf(format,los_chi);
text(0.1,0.2,str);
hold off;

% maksvel distribution
beta = [1];%начальная точка апроксимации
[coeff3,r,J,cov_matrix] = nlinfit(xk, yk, @maksvel_dist, beta);
los_maks = loss(xk,yk,coeff3,sdk,@maksvel_dist)
Y = maksvel_dist(coeff3,xk);
Rk = taken_balance_chart(xk,yk,coeff3,sdk,@maksvel_dist);
Ak = auto_correlation(Rk,k_var);
auto_conf_intervals_3 = nlparci(coeff3,r,'covar',cov_matrix,'alpha',0.32)
me_conf_intefvals_3 = get_intervals(coeff3,cov_matrix,68)

%figure(7);
%grath(xk,Rk,'Взвешаные остатки','x','Rk');
%figure(8);
%grath(0:k_var-1,Ak,['Автокорелиционная функция'],'k','Ak');
%figure(9);
%grath(xk,yk,'Распределение Максвела','x','f');
hold on;
% plot(xk,Y);
% legend('y','f(x,teta)');
format = 'Loss = %3.4f';
str = sprintf(format,los_maks);
text(0.1,0.2,str);
hold off;

figure(10)
grath(xk,yk,'','x','f')
hold on;
grath(xk,normal_dist(coeff1,xk),'','x','f')
grath(xk,chi_dist(coeff2,xk),'','x','f')
grath(xk,maksvel_dist(coeff3,xk),'','x','f')
legend('y','normal','chi square','maksvel');
