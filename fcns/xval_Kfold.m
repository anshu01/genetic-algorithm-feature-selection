function [ tr_idx, t_idx, D ] = xval_Kfold( data_target, options )
%xval_Kfold Returns training/test indices of k-fold cross validation using
%K-folds as defined in options (default 5).
%
%   [ tr_idx, t_idx, D ] = xval_Kfold( data_target, options )

D=options.CrossValidationParam(1);

N=length(data_target);

%=== random indices from 1:N
[~,xval] = sort(rand(N,1),1);

% Calculate cross-validation indices (randomly placed integers 1:D)
xval=mod(xval,D)+1;

% Pre-allocate
tr_idx=false(N,D);
t_idx=false(N,D);

%TODO: make this vectorized
for k=1:D
    t_idx(:,k)=xval==k;
    tr_idx(:,k)=~t_idx(:,k);
end

end

