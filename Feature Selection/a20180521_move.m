function a20180521_move()%task1：整个系统的两种不同的accuracy
    %-----------------读取数据，定义F1，F1+F2对应列-----------------
    fprintf('正在读取数据集1\n');
    dataset_1=xlsread('C:\Users\Administrator\Desktop\PRTools\data\only step1 samples.xlsx');%共47列（46+1）2类
    fprintf('已读取数据集1\n\n');
    fprintf('正在读取数据集2\n');
    dataset_2=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');%共65列（64+1）2类
    fprintf('已读取数据集2\n\n');
    F1_d1=(1:46);
    F1_d2=[16:27,29:33,35:42,44:64];
    F1_and_F2=(1:64);
    F2=[1:15,28,34,43];
    %*************************************************************
    
    %-------------------------feature部分-------------------------
    %C1数据来源于两个数据集
    feature_c1_normal_d1=dataset_1(dataset_1(:,47)==0,F1_d1);
    feature_c1_alzheimer_d1=dataset_1(dataset_1(:,47)==1,F1_d1);
    feature_c1_normal_d2=dataset_2(dataset_2(:,65)==0,F1_d2);
    feature_c1_alzheimer_d2=dataset_2(dataset_2(:,65)==1,F1_d2);
    %C1和C2需要用的数据
    feature_c1_normal=[feature_c1_normal_d1;feature_c1_normal_d2];
    feature_c1_alzheimer=[feature_c1_alzheimer_d1;feature_c1_alzheimer_d2];
    feature_c2_normal=dataset_2(dataset_2(:,65)==0,F1_and_F2);
    feature_c2_alzheimer=dataset_2(dataset_2(:,65)==1,F1_and_F2);
    %顺序打乱（保证每次随机选取部分的顺序不重复）
    rand_c1_normal=randperm(size(feature_c1_normal,1));
    rand_c2_normal=randperm(size(feature_c2_normal,1));
    rand_c1_alzheimer=randperm(size(feature_c1_alzheimer,1));
    rand_c2_alzheimer=randperm(size(feature_c2_alzheimer,1));
    %各训练/测试样本大小
    r1=(1:1747);
    r2=(1748:3494);
    r3=(1:320);
    r4=(321:639);
    r5=(1:116);
    r6=(117:232);
    r7=(1:1403);
    r8=(1404:2806);
    %训练集feature
    feature_c1_normal_train=feature_c1_normal(rand_c1_normal(r1),:);
    feature_c2_normal_train=feature_c2_normal(rand_c2_normal(r3),:);
    feature_c1_alzheimer_train=feature_c1_alzheimer(rand_c1_alzheimer(r5),:);
    feature_c2_alzheimer_train=feature_c2_alzheimer(rand_c2_alzheimer(r7),:);
    %测试集feature
    feature_c1_normal_test=feature_c1_normal(rand_c1_normal(r2),:);
    feature_c2_normal_test=feature_c2_normal(rand_c2_normal(r4),:);
    feature_c1_alzheimer_test=feature_c1_alzheimer(rand_c1_alzheimer(r6),:);
    feature_c2_alzheimer_test=feature_c2_alzheimer(rand_c2_alzheimer(r8),:);
    %***********************2018.5.11 行size检查无误**********************
    
    %---------------------------class部分-------------------------
    %训练集CLASS：三类和两类
    train_class_1_1=zeros(size(feature_c1_normal_train,1),1);%step1正常
    train_class_1_2=ones(size(feature_c2_normal_train,1)+size(feature_c2_alzheimer_train,1),1);%需要做step2
    train_class_1_3=2*ones(size(feature_c1_alzheimer_train,1),1);%step1痴呆
    train_class_2_1=zeros(size(feature_c2_normal_train,1),1);%C2正常
    train_class_2_2=ones(size(feature_c2_alzheimer_train,1),1);%C2痴呆
    %测试集CLASS：四类和两类
    test_class_1_1=zeros(size(feature_c1_normal_test,1),1);%step1正常
    test_class_1_2=ones(size(feature_c2_normal_test,1),1);%需要做step2，正常
    test_class_1_3=2*ones(size(feature_c1_alzheimer_test,1),1);%step1痴呆
    test_class_1_4=3*ones(size(feature_c2_alzheimer_test,1),1);%需要做step2，痴呆
    test_class_2_1=zeros(size(test_class_1_1,1)+size(test_class_1_2,1),1);%正常
    test_class_2_2=ones(size(test_class_1_3,1)+size(test_class_1_4,1),1);%痴呆
    %****************%2018.5.11 21:21 行size检查无误******************
    
    %-----------------------------数据集部分--------------------------
    %C1训练数据集（alzheimer repeat 15次以获得平衡样本）
    train_dataset_c1_normal=[feature_c1_normal_train,train_class_1_1];
    train_dataset_c1_alzheimer_temp=[feature_c1_alzheimer_train,train_class_1_3];
    train_dataset_c1_alzheimer=repmat(train_dataset_c1_alzheimer_temp,15,1);
    train_dataset_c1_uncertain=[[feature_c2_normal_train(:,F1_d2);feature_c2_alzheimer_train(:,F1_d2)],train_class_1_2];
    train_dataset_c1_temp=[train_dataset_c1_normal;train_dataset_c1_alzheimer;train_dataset_c1_uncertain];
    train_dataset_c1=train_dataset_c1_temp(randperm(size(train_dataset_c1_temp,1)),:);
    %C2训练数据集（normal repeat 5次以获得更平衡样本）
    train_dataset_c2_normal_temp=[feature_c2_normal_train,train_class_2_1];
    train_dataset_c2_normal=repmat(train_dataset_c2_normal_temp,5,1);
    train_dataset_c2_alzheimer=[feature_c2_alzheimer_train,train_class_2_2];
    train_dataset_c2_temp=[train_dataset_c2_normal;train_dataset_c2_alzheimer];
    train_dataset_c2_temp=train_dataset_c2_temp(randperm(size(train_dataset_c2_temp,1)),:);
    train_dataset_c2=[train_dataset_c2_temp(:,F1_d2),train_dataset_c2_temp(:,F2),train_dataset_c2_temp(:,65)];
    %整个系统测试数据集的feature部分（backup拿来给C2用，跟编号对应）
    test_dataset_feature=[feature_c1_normal_test;feature_c2_normal_test(:,F1_d2);feature_c1_alzheimer_test;feature_c2_alzheimer_test(:,F1_d2)];
    test_dataset_feature_backup=[[feature_c1_normal_test,ones(size(feature_c1_normal_test,1),18)];feature_c2_normal_test;[feature_c1_alzheimer_test,ones(size(feature_c1_alzheimer_test,1),18)];feature_c2_alzheimer_test];
    %整个系统测试数据集的class部分（四类和二类）
    %四类
    test_dataset_class_4=[test_class_1_1;test_class_1_2;test_class_1_3;test_class_1_4];
    %二类
    test_dataset_class_2=[test_class_2_1;test_class_2_2];
    %整个系统测试数据集（四类和二类）
    test_dataset_rand_4=randperm(size(test_dataset_class_4,1));
    test_dataset_rand_2=randperm(size(test_dataset_class_2,1));
    test_dataset_temp_4=[test_dataset_feature,test_dataset_class_4];
    test_dataset_temp_4_backup=[test_dataset_feature_backup,test_dataset_class_4];
    test_dataset_4=test_dataset_temp_4(test_dataset_rand_4,:);%四类普通
    test_dataset_4_backup=test_dataset_temp_4_backup(test_dataset_rand_4,:);%四类backup
    test_dataset_temp_2=[test_dataset_feature,test_dataset_class_2];
    test_dataset_temp_2_backup=[test_dataset_feature_backup,test_dataset_class_2];
    test_dataset_2=test_dataset_temp_2(test_dataset_rand_2,:);%二类普通
    test_dataset_2_backup=test_dataset_temp_2_backup(test_dataset_rand_2,:);%二类backup
    %***************2018.5.12 10:14 行列size检查无误****************
    
%remove任务
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
        %跳过已用过的情况
        if sum(move_candidate_F1==current_try_feature)==1 
           continue; 
        end
        %remove一些特征
        remove_candidate_F1_temp=move_candidate_F1;
        remove_candidate_F1_temp=[move_candidate_F1,current_try_feature];

        leave_feature_c1=(1:46);
        leave_feature_c1(:,remove_candidate_F1_temp)=[];
        leave_feature_all=[1:65];
        %准备好remove后的训练集和测试集
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