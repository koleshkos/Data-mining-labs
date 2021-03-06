clear all;
close all;
clc;

X = load('data12.txt');

m = 4;
coeff = 1 + rand(1,2,m)*2;
distance = zeros(1,m);
clusters = zeros(size(X,1),1);

k = 1;
k_max = 10;
h = 1e-1;


while(k <= k_max)
    for  i = 1:size(X,1)
        for j = 1:m
            distance(j) = pdist([X(i,:);coeff(:,:,j)]);
        end
        [~,arg] = min(distance);
        coeff(:,:,arg) = coeff(:,:,arg) + h*(X(i,:)-coeff(:,:,arg));
    end
    k = k + 1;
    if(mod(k,10) == 0)
        h = h * 0.2;
    end
end

for i = 1: size(X, 1)
    for j = 1:m
        distance(j) = pdist([X(i,:);coeff(:,:,j)]);
    end
    [~,arg] = min(distance);
    clusters(i) = arg;
end

figure(1)
gscatter(X(:,1), X(:,2), clusters);
hold on;
coeff = reshape(coeff,[2,m]);
plot(coeff(1,:),coeff(2,:),'h','MarkerSize',7,'MarkerEdgeColor','k',...
   'MarkerFaceColor', 'k','DisplayName','centers');
hold off;