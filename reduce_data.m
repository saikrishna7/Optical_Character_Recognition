function[red_train_data,red_test_data]=reduce_data(train_data,test_data,n)
c = mean(train_data);
v=var(train_data);

X = train_data - repmat(c, size(train_data,1), 1);
X=X./repmat(v, size(train_data,1), 1);
covar = cov(X);
[eig_vectors, D] = eigs(covar, n);
red_train_data=train_data*eig_vectors;
red_test_data=test_data*eig_vectors;
end