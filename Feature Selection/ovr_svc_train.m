function [W,L]=ovr_svc_train(data_set,parameter,kernel)
    W={};
    L=[];
    for i=unique(data_set.labels)'
        new_labels=data_set.labels;
        for j=1:size(new_labels,1)
           new_labels(j,1)=new_labels(j,1)~=i;%该类别当正样本，其他类别当负样本（0和1）
        end
        train_ds=dataset(data_set.data,new_labels);%标签改为只有两类的新数据集，数据部分不变
        balanced_train_ds=two_class_data_balance(train_ds);%平衡数据集
        [W{length(W)+1},~]=svc(balanced_train_ds,proxm([],kernel,parameter),1);%训练得到不同的mapping
        L=[L,i];
    end
end