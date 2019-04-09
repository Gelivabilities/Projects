function [acc]=ovr_svc_test(data_set,W,L)
    result=[];
    count=1; 
    for i=L
        new_labels=data_set.labels;
        for j=1:size(new_labels,1)
           new_labels(j,1)=new_labels(j,1)~=i;%�������������������𵱸�������0��1��
        end
        test_ds=dataset(data_set.data,new_labels);%��ǩ��Ϊֻ������������ݼ������ݲ��ֲ���        
       result_temp=test_ds*W{count};
       result=[result,result_temp.data(:,1)];
       count=count+1;
    end
    %������������������࣬��Ϊ�����Ľ��
    [~,y]=max(result');
    rows=size(y,2);
    classification_result=zeros(rows,1);
    for i=1:rows
        classification_result(i)=L(y(i));
    end
    %����accuracy
    accuracy=sum(classification_result==data_set.labels)/size(classification_result,1);
    %ÿ��class��accuracy
    num_of_classes=size(L,2);
    acc_per_class=zeros(1,num_of_classes);
    for i=1:num_of_classes
        %��i��������ķ�����
        Ci_rows=data_set.labels==L(i);
        result_i=classification_result(Ci_rows,:);
        acc_per_class(i)=sum(result_i==L(i))/sum(Ci_rows);
    end
    acc=[accuracy,acc_per_class];
end