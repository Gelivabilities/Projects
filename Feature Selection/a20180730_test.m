function a20180730_test()
    acc=[];
    num_of_features=0;
    num_of_epoch=10;
    for j=1:num_of_epoch
       acc=[a20180729_SVM(3),acc];
       if j==1
          num_of_features=size(acc,1); 
       end
       acc(1:num_of_features,:)
    end
    m=[1:2:2*num_of_epoch-1];
    a=mean(acc(:,m)');
    b=mean(acc(:,m+ones())');
    [a',b']
end
%20180730 15:55 �������������ʦ����features����2��matlab��
%20180730 16:12 �����������correlation features����3��matlab��
%20180731 16:28 �������������������ͬ���ͬʱ�ܣ�����1��matlab��
%20180731 17:24 ����������������ݼ�����1��matlab��