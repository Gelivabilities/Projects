function [W1_1,W1_2,W2]=a20180528_system_train(dataset_c1,dataset_c2,num_of_f1,num_of_all)%�ֲ㷨ѵ��W1_1,W1_2���ˣ����Ե�ʱ������Ƿ���������
    %c1(3��)�÷ֲ㷽�����ࣺ�ȷ������࣬Ȼ���ٴ�����һ�������зֳ�С��
    %����Hierarchical Support Vector Machine for Multi-classClassification
    %�˴�ֻ�����࣬��ֱ���ֶ��ֲ㣨���������ֲ�ͬ�ĳ��ԣ�,��������ѵ��
    %���²�ѵ�������ݼ�(�ж�ֻ��step1�����Ƿ�մ���0������1�մ�)
    dataset_c1_bottom=dataset_c1(dataset_c1(:,num_of_f1+1)~=1,:);
    d1_bottom=dataset(dataset_c1_bottom(:,1:num_of_f1),dataset_c1_bottom(:,num_of_f1+1));%�²�ѵ�����ݼ�
    %���ϲ�ѵ�������ݼ�(�ж��Ƿ�Ҫ����step2,0�ǲ��ã�1��Ҫ)
    dataset_c1_top_temp=dataset_c1;
    dataset_c1_top_temp(dataset_c1(:,num_of_f1+1)==2,num_of_f1+1)=0;
    %ƽ�⣨certain�ı�uncertain�Ķࣩ
    dataset_c1_top_0_temp=dataset_c1_top_temp(dataset_c1_top_temp(:,num_of_f1+1)==0,:);
    dataset_c1_top_0=dataset_c1_top_0_temp(1:1723,:);
    dataset_c1_top_1=dataset_c1_top_temp(dataset_c1_top_temp(:,num_of_f1+1)==1,:);
    dataset_c1_top_combine=[dataset_c1_top_0;dataset_c1_top_1];
    dataset_c1_top=dataset_c1_top_combine(randperm(size(dataset_c1_top_combine,1)),:);
    d1_top=dataset(dataset_c1_top(:,1:num_of_f1),dataset_c1_top(:,num_of_f1+1));%�ϲ�ѵ�����ݼ�
    
    d2=dataset(dataset_c2(:,1:num_of_all),dataset_c2(:,num_of_all+1));
    %*****************2018.5.12 12:06 dataset��������*********************
    
%�ֲ㷨  
    %ѵ���ײ���������SVM
    W1_2=svc(d1_top,proxm([],'r',4),1);%4
    W1_1=svc(d1_bottom,proxm([],'r',16),1);%16
    
    %**********2018.5.12 12:16 C1�ֲ���������²��Ϊ46x2 mapping**********
    %*******************2018.5.12 17:31 ѵ������������*******************
    
    %c2(2��)
    W2=svc(d2,proxm([],'r',10),1);%7
    %***********************2018.5.12 64x2 mapping************************
    %*******************2018.5.12 17:31 ѵ������������*******************
end