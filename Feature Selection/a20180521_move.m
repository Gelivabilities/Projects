function a20180521_move()%task1������ϵͳ�����ֲ�ͬ��accuracy
    %-----------------��ȡ���ݣ�����F1��F1+F2��Ӧ��-----------------
    fprintf('���ڶ�ȡ���ݼ�1\n');
    dataset_1=xlsread('C:\Users\Administrator\Desktop\PRTools\data\only step1 samples.xlsx');%��47�У�46+1��2��
    fprintf('�Ѷ�ȡ���ݼ�1\n\n');
    fprintf('���ڶ�ȡ���ݼ�2\n');
    dataset_2=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');%��65�У�64+1��2��
    fprintf('�Ѷ�ȡ���ݼ�2\n\n');
    F1_d1=(1:46);
    F1_d2=[16:27,29:33,35:42,44:64];
    F1_and_F2=(1:64);
    F2=[1:15,28,34,43];
    %*************************************************************
    
    %-------------------------feature����-------------------------
    %C1������Դ���������ݼ�
    feature_c1_normal_d1=dataset_1(dataset_1(:,47)==0,F1_d1);
    feature_c1_alzheimer_d1=dataset_1(dataset_1(:,47)==1,F1_d1);
    feature_c1_normal_d2=dataset_2(dataset_2(:,65)==0,F1_d2);
    feature_c1_alzheimer_d2=dataset_2(dataset_2(:,65)==1,F1_d2);
    %C1��C2��Ҫ�õ�����
    feature_c1_normal=[feature_c1_normal_d1;feature_c1_normal_d2];
    feature_c1_alzheimer=[feature_c1_alzheimer_d1;feature_c1_alzheimer_d2];
    feature_c2_normal=dataset_2(dataset_2(:,65)==0,F1_and_F2);
    feature_c2_alzheimer=dataset_2(dataset_2(:,65)==1,F1_and_F2);
    %˳����ң���֤ÿ�����ѡȡ���ֵ�˳���ظ���
    rand_c1_normal=randperm(size(feature_c1_normal,1));
    rand_c2_normal=randperm(size(feature_c2_normal,1));
    rand_c1_alzheimer=randperm(size(feature_c1_alzheimer,1));
    rand_c2_alzheimer=randperm(size(feature_c2_alzheimer,1));
    %��ѵ��/����������С
    r1=(1:1747);
    r2=(1748:3494);
    r3=(1:320);
    r4=(321:639);
    r5=(1:116);
    r6=(117:232);
    r7=(1:1403);
    r8=(1404:2806);
    %ѵ����feature
    feature_c1_normal_train=feature_c1_normal(rand_c1_normal(r1),:);
    feature_c2_normal_train=feature_c2_normal(rand_c2_normal(r3),:);
    feature_c1_alzheimer_train=feature_c1_alzheimer(rand_c1_alzheimer(r5),:);
    feature_c2_alzheimer_train=feature_c2_alzheimer(rand_c2_alzheimer(r7),:);
    %���Լ�feature
    feature_c1_normal_test=feature_c1_normal(rand_c1_normal(r2),:);
    feature_c2_normal_test=feature_c2_normal(rand_c2_normal(r4),:);
    feature_c1_alzheimer_test=feature_c1_alzheimer(rand_c1_alzheimer(r6),:);
    feature_c2_alzheimer_test=feature_c2_alzheimer(rand_c2_alzheimer(r8),:);
    %***********************2018.5.11 ��size�������**********************
    
    %---------------------------class����-------------------------
    %ѵ����CLASS�����������
    train_class_1_1=zeros(size(feature_c1_normal_train,1),1);%step1����
    train_class_1_2=ones(size(feature_c2_normal_train,1)+size(feature_c2_alzheimer_train,1),1);%��Ҫ��step2
    train_class_1_3=2*ones(size(feature_c1_alzheimer_train,1),1);%step1�մ�
    train_class_2_1=zeros(size(feature_c2_normal_train,1),1);%C2����
    train_class_2_2=ones(size(feature_c2_alzheimer_train,1),1);%C2�մ�
    %���Լ�CLASS�����������
    test_class_1_1=zeros(size(feature_c1_normal_test,1),1);%step1����
    test_class_1_2=ones(size(feature_c2_normal_test,1),1);%��Ҫ��step2������
    test_class_1_3=2*ones(size(feature_c1_alzheimer_test,1),1);%step1�մ�
    test_class_1_4=3*ones(size(feature_c2_alzheimer_test,1),1);%��Ҫ��step2���մ�
    test_class_2_1=zeros(size(test_class_1_1,1)+size(test_class_1_2,1),1);%����
    test_class_2_2=ones(size(test_class_1_3,1)+size(test_class_1_4,1),1);%�մ�
    %****************%2018.5.11 21:21 ��size�������******************
    
    %-----------------------------���ݼ�����--------------------------
    %C1ѵ�����ݼ���alzheimer repeat 15���Ի��ƽ��������
    train_dataset_c1_normal=[feature_c1_normal_train,train_class_1_1];
    train_dataset_c1_alzheimer_temp=[feature_c1_alzheimer_train,train_class_1_3];
    train_dataset_c1_alzheimer=repmat(train_dataset_c1_alzheimer_temp,15,1);
    train_dataset_c1_uncertain=[[feature_c2_normal_train(:,F1_d2);feature_c2_alzheimer_train(:,F1_d2)],train_class_1_2];
    train_dataset_c1_temp=[train_dataset_c1_normal;train_dataset_c1_alzheimer;train_dataset_c1_uncertain];
    train_dataset_c1=train_dataset_c1_temp(randperm(size(train_dataset_c1_temp,1)),:);
    %C2ѵ�����ݼ���normal repeat 5���Ի�ø�ƽ��������
    train_dataset_c2_normal_temp=[feature_c2_normal_train,train_class_2_1];
    train_dataset_c2_normal=repmat(train_dataset_c2_normal_temp,5,1);
    train_dataset_c2_alzheimer=[feature_c2_alzheimer_train,train_class_2_2];
    train_dataset_c2_temp=[train_dataset_c2_normal;train_dataset_c2_alzheimer];
    train_dataset_c2_temp=train_dataset_c2_temp(randperm(size(train_dataset_c2_temp,1)),:);
    train_dataset_c2=[train_dataset_c2_temp(:,F1_d2),train_dataset_c2_temp(:,F2),train_dataset_c2_temp(:,65)];
    %����ϵͳ�������ݼ���feature���֣�backup������C2�ã�����Ŷ�Ӧ��
    test_dataset_feature=[feature_c1_normal_test;feature_c2_normal_test(:,F1_d2);feature_c1_alzheimer_test;feature_c2_alzheimer_test(:,F1_d2)];
    test_dataset_feature_backup=[[feature_c1_normal_test,ones(size(feature_c1_normal_test,1),18)];feature_c2_normal_test;[feature_c1_alzheimer_test,ones(size(feature_c1_alzheimer_test,1),18)];feature_c2_alzheimer_test];
    %����ϵͳ�������ݼ���class���֣�����Ͷ��ࣩ
    %����
    test_dataset_class_4=[test_class_1_1;test_class_1_2;test_class_1_3;test_class_1_4];
    %����
    test_dataset_class_2=[test_class_2_1;test_class_2_2];
    %����ϵͳ�������ݼ�������Ͷ��ࣩ
    test_dataset_rand_4=randperm(size(test_dataset_class_4,1));
    test_dataset_rand_2=randperm(size(test_dataset_class_2,1));
    test_dataset_temp_4=[test_dataset_feature,test_dataset_class_4];
    test_dataset_temp_4_backup=[test_dataset_feature_backup,test_dataset_class_4];
    test_dataset_4=test_dataset_temp_4(test_dataset_rand_4,:);%������ͨ
    test_dataset_4_backup=test_dataset_temp_4_backup(test_dataset_rand_4,:);%����backup
    test_dataset_temp_2=[test_dataset_feature,test_dataset_class_2];
    test_dataset_temp_2_backup=[test_dataset_feature_backup,test_dataset_class_2];
    test_dataset_2=test_dataset_temp_2(test_dataset_rand_2,:);%������ͨ
    test_dataset_2_backup=test_dataset_temp_2_backup(test_dataset_rand_2,:);%����backup
    %***************2018.5.12 10:14 ����size�������****************
    
%remove����
epoch=45;
acc_all=zeros(epoch+1,1);
move_candidate_F1=[];

[W_C1_2,W_C1_1,W_C2]=a20180509_train(train_dataset_c1,train_dataset_c2,46,64);
acc2=a20180509_test(test_dataset_4,test_dataset_2,test_dataset_4_backup,test_dataset_2_backup,W_C1_1,W_C1_2,W_C2,2,46,64);
acc_all(1)=acc2(3);
for remove_num=(1+size(move_candidate_F1,2)):epoch
    acc_max=0;
    index=0;
    for current_try_feature=1:46
        %�������ù������
        if sum(move_candidate_F1==current_try_feature)==1 
           continue; 
        end
        %removeһЩ����
        remove_candidate_F1_temp=move_candidate_F1;
        remove_candidate_F1_temp=[move_candidate_F1,current_try_feature];

        leave_feature_c1=(1:46);
        leave_feature_c1(:,remove_candidate_F1_temp)=[];
        leave_feature_all=[1:65];
        %׼����remove���ѵ�����Ͳ��Լ�
        train_dataset_c1_current=train_dataset_c1(:,[leave_feature_c1,47]);
        train_dataset_c2_current=train_dataset_c2(:,leave_feature_all);
        test_dataset_4_current=test_dataset_4(:,[leave_feature_c1,47]);
        test_dataset_2_current=test_dataset_2(:,[leave_feature_c1,47]);
        test_dataset_4_backup_current=test_dataset_4_backup(:,leave_feature_all);
        test_dataset_2_backup_current=test_dataset_2_backup(:,leave_feature_all);
        [W_C1_2,W_C1_1,W_C2]=a20180509_train(train_dataset_c1_current,train_dataset_c2_current,46-size(remove_candidate_F1_temp,2),64);
        acc_current_temp=a20180509_test(test_dataset_4_current,test_dataset_2_current,test_dataset_4_backup_current,test_dataset_2_backup_current,W_C1_1,W_C1_2,W_C2,2,46-size(remove_candidate_F1_temp,2),64);
        acc_current=acc_current_temp(:,3);
        if acc_current>acc_max
            acc_max=max(acc_max,acc_current);
            index=current_try_feature;
        end
        fprintf('cur: %d, max: %d, maxacc: %f ',current_try_feature,index,acc_max);
        if mod(current_try_feature,4)==0
            fprintf('\n');
        end
    end
    if index<=46 
        move_candidate_F1=[move_candidate_F1,index];
    else
        move_candidate_F2=[move_candidate_F2,index];
    end
    acc_all(remove_num+1)=acc_max;
    move_candidate_F1
    acc_max
end
acc_all
move_candidate_F1
end