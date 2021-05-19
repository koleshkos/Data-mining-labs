clear all;
close all;
clc;

fid = fopen('Learning_data12.txt', 'r');
Learning = fscanf(fid, '%g %g %g %g %g %g %g %g', [8 inf]);
fclose(fid);

T = [1 10;1 10; 1 10; 1 10; 1 10; 1 10; 1 10; 1 10];
%Создать нейронную сеть (например, 2?2) на основе карт Кохонена
net = newsom(T,[2 2]);
%ф-ция классификации векторов входа по нейронной сети Learning
net.trainParam.epochs = 100; %набор параметров обучения
net = train(net, Learning);%обучение сети соответсвующим набором
%Классифицировать исходные объекты в кластеры с использованием разработанной нейронной сети
W =sim(net,Learning);
Klasters = vec2ind(W);%конвертирует классифицированные объекты в индексы нейронов

fid = fopen('PCA_data12.txt', 'r');
PCA = fscanf(fid, '%g %g ', [2 inf]);
fclose(fid);

countCl1 = 1; countCl2 = 1; countCl3 = 1; countCl4 = 1;%счетчики
C1 = zeros(2); C2 = zeros(2); C3 = zeros(2); C4 = zeros(2);%координаты нейрона
clust1 = zeros(8); clust2 = zeros(8); clust3 = zeros(8); clust4 = zeros(8);
%Сгруппировать объекты в кластеры
for i = 1:length(Klasters)
    if(Klasters(i) == 1)
        C1(countCl1,:) = PCA(:,i);
        clust1(countCl1,:) = Learning(:,i);
        countCl1 = countCl1 + 1;
    end
    if(Klasters(i) == 2)
        C2(countCl2,:) = PCA(:,i);
        clust2(countCl2,:) = Learning(:,i);
        countCl2 = countCl2 + 1;
    end
    if(Klasters(i) == 3)
        C3(countCl3,:) = PCA(:,i);
        clust3(countCl3,:) = Learning(:,i);
        countCl3 = countCl3 + 1;
    end
    if(Klasters(i) == 4)
        C4(countCl4,:) = PCA(:,i);
        clust4(countCl4,:) = Learning(:,i);
        countCl4 = countCl4 + 1;
    end
end

%Центры кластеров данных из PCA
M_PCA(1,:) = mean(C1);
M_PCA(2,:) = mean(C2);
M_PCA(3,:) = mean(C3);
M_PCA(4,:) = mean(C4);

%Отображение центров кластеров
figure
gscatter(PCA(1,:),PCA(2,:),Klasters);
hold on
plot(M_PCA(:,1),M_PCA(:,2),'*');
hold off

%Cредние значения по каждому признаку в кластерах
M(1,:) = mean(clust1);
M(2,:) = mean(clust2);
M(3,:) = mean(clust3);
M(4,:) = mean(clust4);
M

%График средних значений признаков объектов попавших в кластер
figure
plot(M(1, :),'r');
hold on
plot(M(2, :),'g');
plot(M(3, :),'b');
plot(M(4, :),'black');
title('График средних значений признаков');

figure
for i=1:4
    subplot(2, 2, i);
    %subplot(m, n, p) производит разбивку графического окна на несколько 
    %подокон, создавая при этом новые объекты axes; значение m указывает, 
    %на сколько частей разбивается окно по горизонтали, n - по вертикали, 
    %а p - номер подокна, куда будет выводиться очередной график
    plot(M(i, :));
    axis([1 8 1 10]);%масштаб по осям
    title(['Cluster №:',num2str(i)]);
end