function [ t_cost, tr_cost, stats ] = fit_SVM_CV(DATA,data_target,costFcn)

% Randomly select training and test sets.
if nargin<3
    costFcn=@cost_RMSE;
end
ki = 1;
KI=10;
tr_cost=zeros(KI,1);
t_cost=zeros(KI,1);

mdl=cell(KI,1);

% repeat until the mean of the AUC is significant
idx = crossvalind('Kfold', size(data_target,1) , KI);
while ki<=KI
    idx_temp=idx==ki;
    train_data = DATA(~idx_temp,:);
    train_target = data_target(~idx_temp);
    valid_data = DATA(idx_temp,:);
    valid_target = data_target(idx_temp);
    
    % train the SVM using LIBSVM
    mdl{ki} = svmtrain(train_target, train_data, '-b 1');
    [train_pred, tr_acc, tr_prob] = svmpredict(train_target, train_data, mdl{ki}, '-b 1');
    [valid_pred, v_acc, v_prob] = svmpredict(valid_target, valid_data, mdl{ki}, '-b 1');
    
    if sum(round(v_prob(:,1)))==sum(valid_pred)
        train_pred=tr_prob(:,1);
        valid_pred=v_prob(:,1);
        
    else
        train_pred=tr_prob(:,2);
        valid_pred=v_prob(:,2);
    end
    t_cost(ki) = feval(costFcn, valid_pred, valid_target);
    tr_cost(ki) = feval(costFcn, train_pred, train_target);
    ki = ki+1;
end


if nargout>2
    [~,median_idx]=min(abs(t_cost-nanmedian(t_cost)));
    idx_temp=idx==median_idx;
    valid_data = DATA(idx_temp,:);
    valid_target = data_target(idx_temp);
    
    [valid_pred, v_acc, v_prob] = svmpredict(valid_target, valid_data, mdl{ki}, '-b 1');
    
    if sum(round(v_prob(:,1)))==sum(valid_pred)
        valid_pred=v_prob(:,1);
        
    else
        valid_pred=v_prob(:,2);
    end
    stats=stat_calc_struct(valid_pred,valid_target);
end