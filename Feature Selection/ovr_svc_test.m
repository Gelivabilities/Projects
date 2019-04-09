function [acc]=ovr_svc_test(data_set,W,L)
    result=[];
    count=1; 
    for i=L
        new_labels=data_set.labels;
        for j=1:size(new_labels,1)
           new_labels(j,1)=new_labels(j,1)~=i;%该类别当正样本，其他类别当负样本（0和1）
        end
        test_ds=dataset(data_set.data,new_labels);%标签改为只有两类的新数据集，数据部分不变        
       result_temp=test_ds*W{count};
       result=[result,result_temp.data(:,1)];
       count=count+1;
    end
    %多类里面概率最大的那类，作为多分类的结果
    [~,y]=max(result');
    rows=size(y,2);
    classification_result=zeros(rows,1);
    for i=1:rows
        classification_result(i)=L(y(i));
    end
    %整体accuracy
    accuracy=sum(classification_result==data_set.labels)/size(classification_result,1);
    %每个class的accuracy
    num_of_classes=size(L,2);
    acc_per_class=zeros(1,num_of_classes);
    for i=1:num_of_classes
        %第i类的样本的分类结果
        Ci_rows=data_set.labels==L(i);
        result_i=classification_result(Ci_rows,:);
        acc_per_class(i)=sum(result_i==L(i))/sum(Ci_rows);
    end
    acc=[accuracy,acc_per_class];
end