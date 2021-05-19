function [c,value] = st_search(N)
X_i = [(-5+(5+5)*rand(1,N));(-5+(5+5)*rand(1,N))];
F_i = F(X_i(1,:),X_i(2,:));
[value,arg] = min(F_i);
c = X_i(:,arg);
end