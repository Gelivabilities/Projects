function [W,L]=ovr_svc_train(data_set,parameter,kernel)
    W={};
    L=[];
    for i=unique(data_set.labels)'
        new_labels=data_set.labels;
        for j=1:size(new_labels,1)
           new_labels(j,1)=new_labels(j,1)~=i;%�������������������𵱸�������0��1��
        end
        train_ds=dataset(data_set.data,new_labels);%��ǩ��Ϊֻ������������ݼ������ݲ��ֲ���
        balanced_train_ds=two_class_data_balance(train_ds);%ƽ�����ݼ�
        [W{length(W)+1},~]=svc(balanced_train_ds,proxm([],kernel,parameter),1);%ѵ���õ���ͬ��mapping
        L=[L,i];
    end
end