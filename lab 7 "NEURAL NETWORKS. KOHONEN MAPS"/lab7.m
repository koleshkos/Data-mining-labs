clear all;
close all;
clc;

fid = fopen('Learning_data12.txt', 'r');
Learning = fscanf(fid, '%g %g %g %g %g %g %g %g', [8 inf]);
fclose(fid);

T = [1 10;1 10; 1 10; 1 10; 1 10; 1 10; 1 10; 1 10];
%������� ��������� ���� (��������, 2?2) �� ������ ���� ��������
net = newsom(T,[2 2]);
%�-��� ������������� �������� ����� �� ��������� ���� Learning
net.trainParam.epochs = 100; %����� ���������� ��������
net = train(net, Learning);%�������� ���� �������������� �������
%���������������� �������� ������� � �������� � �������������� ������������� ��������� ����
W =sim(net,Learning);
Klasters = vec2ind(W);%������������ ������������������ ������� � ������� ��������

fid = fopen('PCA_data12.txt', 'r');
PCA = fscanf(fid, '%g %g ', [2 inf]);
fclose(fid);

countCl1 = 1; countCl2 = 1; countCl3 = 1; countCl4 = 1;%��������
C1 = zeros(2); C2 = zeros(2); C3 = zeros(2); C4 = zeros(2);%���������� �������
clust1 = zeros(8); clust2 = zeros(8); clust3 = zeros(8); clust4 = zeros(8);
%������������� ������� � ��������
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

%������ ��������� ������ �� PCA
M_PCA(1,:) = mean(C1);
M_PCA(2,:) = mean(C2);
M_PCA(3,:) = mean(C3);
M_PCA(4,:) = mean(C4);

%����������� ������� ���������
figure
gscatter(PCA(1,:),PCA(2,:),Klasters);
hold on
plot(M_PCA(:,1),M_PCA(:,2),'*');
hold off

%C������ �������� �� ������� �������� � ���������
M(1,:) = mean(clust1);
M(2,:) = mean(clust2);
M(3,:) = mean(clust3);
M(4,:) = mean(clust4);
M

%������ ������� �������� ��������� �������� �������� � �������
figure
plot(M(1, :),'r');
hold on
plot(M(2, :),'g');
plot(M(3, :),'b');
plot(M(4, :),'black');
title('������ ������� �������� ���������');

figure
for i=1:4
    subplot(2, 2, i);
    %subplot(m, n, p) ���������� �������� ������������ ���� �� ��������� 
    %�������, �������� ��� ���� ����� ������� axes; �������� m ���������, 
    %�� ������� ������ ����������� ���� �� �����������, n - �� ���������, 
    %� p - ����� �������, ���� ����� ���������� ��������� ������
    plot(M(i, :));
    axis([1 8 1 10]);%������� �� ����
    title(['Cluster �:',num2str(i)]);
end