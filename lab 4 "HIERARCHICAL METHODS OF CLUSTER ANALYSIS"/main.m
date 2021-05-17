data = load('data12.txt');

loss = ['seuclidean','cityblock','chebychev'];
method = ['single', 'complete', 'centroid'];
K = zeros(size(loss));

for i = 1:3
    for j = 1:3
        D = pdist(data,loss(j));
        sq_form = squareform(D);
        Z = linkage(sq_form, method(i));
        K(i,j) = cophenet(Z,D);
    end
end

[~,arg] = max(mean(K,2));
best_method = method(arg);
[~,arg] = min(mean(K,2));
worst_method = method(arg);

[~,arg] = max(mean(K,1));
best_loss = loss(arg);
[~,arg] = min(mean(K,1));
worst_loss = loss(arg);

best_model =linkage(squareform(pdist(data,best_loss)),best_method);
dendogram(best_model);