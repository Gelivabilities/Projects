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
%20180730 15:55 有随机噪声，老师方法features（第2个matlab）
%20180730 16:12 有随机噪声，correlation features（第3个matlab）
%20180731 16:28 有随机噪声，两个方法同起点同时跑，（第1个matlab）
%20180731 17:24 有随机噪声，新数据集（第1个matlab）