function [W1_1,W1_2,W2]=a20180528_system_train(dataset_c1,dataset_c2,num_of_f1,num_of_all)%分层法训练W1_1,W1_2反了，测试的时候把它们反过来就行
    %c1(3类)用分层方法分类：先分两大类，然后再从其中一个大类中分出小类
    %文献Hierarchical Support Vector Machine for Multi-classClassification
    %此处只有三类，可直接手动分层（可以有三种不同的尝试）,从下往上训练
    %给下层训练的数据集(判断只需step1的人是否痴呆，0正常，1痴呆)
    dataset_c1_bottom=dataset_c1(dataset_c1(:,num_of_f1+1)~=1,:);
    d1_bottom=dataset(dataset_c1_bottom(:,1:num_of_f1),dataset_c1_bottom(:,num_of_f1+1));%下层训练数据集
    %给上层训练的数据集(判断是否要进入step2,0是不用，1是要)
    dataset_c1_top_temp=dataset_c1;
    dataset_c1_top_temp(dataset_c1(:,num_of_f1+1)==2,num_of_f1+1)=0;
    %平衡（certain的比uncertain的多）
    dataset_c1_top_0_temp=dataset_c1_top_temp(dataset_c1_top_temp(:,num_of_f1+1)==0,:);
    dataset_c1_top_0=dataset_c1_top_0_temp(1:1723,:);
    dataset_c1_top_1=dataset_c1_top_temp(dataset_c1_top_temp(:,num_of_f1+1)==1,:);
    dataset_c1_top_combine=[dataset_c1_top_0;dataset_c1_top_1];
    dataset_c1_top=dataset_c1_top_combine(randperm(size(dataset_c1_top_combine,1)),:);
    d1_top=dataset(dataset_c1_top(:,1:num_of_f1),dataset_c1_top(:,num_of_f1+1));%上层训练数据集
    
    d2=dataset(dataset_c2(:,1:num_of_all),dataset_c2(:,num_of_all+1));
    %*****************2018.5.12 12:06 dataset划分无误*********************
    
%分层法  
    %训练底部、顶部的SVM
    W1_2=svc(d1_top,proxm([],'r',4),1);%4
    W1_1=svc(d1_bottom,proxm([],'r',16),1);%16
    
    %**********2018.5.12 12:16 C1分层分类器上下层均为46x2 mapping**********
    %*******************2018.5.12 17:31 训练情况检查正常*******************
    
    %c2(2类)
    W2=svc(d2,proxm([],'r',10),1);%7
    %***********************2018.5.12 64x2 mapping************************
    %*******************2018.5.12 17:31 训练情况检查正常*******************
end