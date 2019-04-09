function a20180509()%task1������ϵͳ�����ֲ�ͬ��accuracy
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
    train_dataset_c2=[train_dataset_c2_temp(:,F1_d2),train_dataset_c2_temp(:,F2),train_dataset_c2_temp(:,65)];%�а���F1��F2��˳��
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
    
% % ϵͳ���ܲ��ԡ����ε�
% para_acc=zeros(10+9+9+199,10);
% i=1;
% for parameter=[2:200,0.001:0.001:0.01,0.02:0.01:0.1,0.2:0.1:1]%�о�ÿ��svm���������ܹ��ڲ����ı仯
%     %���ÿ������SVM�����������ܣ�C1��������C2��һ����
%     
%     %ѵ���Ͳ���
%     %C1�ϲ�
%     dataset_c1_top_temp=train_dataset_c1;
%     dataset_c1_top_temp(train_dataset_c1(:,47)==2,47)=0;
%     dataset_c1_top_0_temp=dataset_c1_top_temp(dataset_c1_top_temp(:,47)==0,:);
%     dataset_c1_top_0=dataset_c1_top_0_temp(1:1723,:);
%     dataset_c1_top_1=dataset_c1_top_temp(dataset_c1_top_temp(:,47)==1,:);
%     dataset_c1_top_combine=[dataset_c1_top_0;dataset_c1_top_1];
%     dataset_c1_top=dataset_c1_top_combine(randperm(size(dataset_c1_top_combine,1)),:);
%     d1_top=dataset(dataset_c1_top(:,1:46),dataset_c1_top(:,47));%�ϲ�ѵ�����ݼ�
%     d1_top=d1_top(1:500,:);
%     W1_top=svc(d1_top,proxm([],'r',parameter*sqrt(2)),1);%46ά����Ϊֻ��һ���׶Ρ������׶ζ�Ҫ���ģ�����ȥ
%     %C1�ϲ����ݼ����������ݣ�46�������������ȷ��0�Ͳ�ȷ��1��
%     certain_feature=[feature_c1_normal_test;feature_c1_alzheimer_test];
%     uncertain_feature=[feature_c2_normal_test(:,F1_d2);feature_c2_alzheimer_test(:,F1_d2)];%ȡ��һ�׶ε�46��
%     test_d1_top=dataset([certain_feature;uncertain_feature],[zeros(size(certain_feature,1),1);ones(size(uncertain_feature,1),1)]);
%     
%     %C1�²�
%     dataset_c1_bottom=train_dataset_c1(train_dataset_c1(:,47)~=1,:);
%     d1_bottom=dataset(dataset_c1_bottom(:,1:46),dataset_c1_bottom(:,47));
%     d1_bottom=d1_bottom(1:500,:);
%     W1_bottom=svc(d1_bottom,proxm([],'r',parameter*sqrt(2)),1);%46ά����Ϊ�մ��Ͳ��մ��Ķ���ȥ
%     acc_1_1=Get_Accuracy(test_d1_top,W1_top);
%     %C1�²����ݼ����������ݣ�46�����������������0�ͳմ�1��
%     normal_feature=[feature_c1_normal_test;feature_c2_normal_test(:,F1_d2)];
%     alzheimer_feature=[feature_c1_alzheimer_test;feature_c2_alzheimer_test(:,F1_d2)];
%     test_d1_bottom=dataset([normal_feature;alzheimer_feature],[zeros(size(normal_feature,1),1);ones(size(alzheimer_feature,1),1)]);
%     acc_1_2=Get_Accuracy(test_d1_bottom,W1_bottom);
%     
%     %C2
%     d2=dataset(train_dataset_c2(:,1:64),train_dataset_c2(:,65));
%     d2=d2(1:500,:);
%     W2=svc(d2,proxm([],'r',parameter*sqrt(2)),1);%����65ά�����ݶ���ȥ
%     %C2���ݼ�������uncertain���ݣ�����������
%     %feature˳��Ҫ������
%     C2_normal_test=[feature_c2_normal_test(:,F1_d2),feature_c2_normal_test(:,F2)];
%     C2_alzheimer_test=[feature_c2_alzheimer_test(:,F1_d2),feature_c2_alzheimer_test(:,F2)];
%     test_d2=dataset([C2_normal_test();C2_alzheimer_test()],[zeros(size(feature_c2_normal_test,1),1);ones(size(feature_c2_alzheimer_test,1),1)]);
%     acc_2=Get_Accuracy(test_d2,W2);
%     
%     para_acc(i,:)=[parameter,acc_1_1(1),acc_1_2(1),acc_2(1),acc_1_1(2),acc_1_2(2),acc_2(2),acc_1_1(3),acc_1_2(3),acc_2(3)];
%     fprintf('para: %.4f, C1 acc: %.4f and %.4f, C2 acc: %.4f\n',para_acc(i,1),para_acc(i,2),para_acc(i,3),para_acc(i,4));
%     i=i+1;
% end
% para_acc
%% remove����
epoch=63;
acc_all=zeros(epoch+1,1);
remove_candidate_F1=[];
remove_candidate_F2=[];

[W_C1_2,W_C1_1,W_C2]=a20180509_train(train_dataset_c1,train_dataset_c2,46,64);
acc2=a20180509_test(test_dataset_4,test_dataset_2,test_dataset_4_backup,test_dataset_2_backup,W_C1_1,W_C1_2,W_C2,2,46,64);
acc_all(1)=acc2(3);
for remove_num=(1+size(remove_candidate_F1,2)+size(remove_candidate_F2,2)):epoch
    acc_max=0;
    index=0;
    for current_try_feature=1:64
        %�������ù������
        if sum(remove_candidate_F1==current_try_feature)==1 || sum(remove_candidate_F2==current_try_feature)==1
           continue; 
        end
        %removeһЩ����
        remove_candidate_F1_temp=remove_candidate_F1;
        remove_candidate_F2_temp=remove_candidate_F2;
        if current_try_feature<=46
            remove_candidate_F1_temp=[remove_candidate_F1,current_try_feature];
        else
            remove_candidate_F2_temp=[remove_candidate_F2,current_try_feature];
        end
        leave_feature_c1=(1:46);
        leave_feature_c2=(1:64);
        leave_feature_c1(:,remove_candidate_F1_temp)=[];
        leave_feature_c2(:,remove_candidate_F2_temp)=[];
        leave_feature_c2(:,1:46)=[];
        leave_feature_all=[leave_feature_c1,leave_feature_c2,65];
        %׼����remove���ѵ�����Ͳ��Լ�
        train_dataset_c1_current=train_dataset_c1(:,[leave_feature_c1,47]);
        train_dataset_c2_current=train_dataset_c2(:,leave_feature_all);
        test_dataset_4_current=test_dataset_4(:,[leave_feature_c1,47]);
        test_dataset_2_current=test_dataset_2(:,[leave_feature_c1,47]);
        test_dataset_4_backup_current=test_dataset_4_backup(:,leave_feature_all);
        test_dataset_2_backup_current=test_dataset_2_backup(:,leave_feature_all);
        [W_C1_2,W_C1_1,W_C2]=a20180509_train(train_dataset_c1_current,train_dataset_c2_current,46-size(remove_candidate_F1_temp,2),64-remove_num);
        acc_current_temp=a20180509_test(test_dataset_4_current,test_dataset_2_current,test_dataset_4_backup_current,test_dataset_2_backup_current,W_C1_1,W_C1_2,W_C2,4,46-size(remove_candidate_F1_temp,2),64-remove_num);
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
        remove_candidate_F1=[remove_candidate_F1,index];
    else
        remove_candidate_F2=[remove_candidate_F2,index];
    end
    acc_all(remove_num+1)=acc_max;
    [remove_candidate_F1,remove_candidate_F2]
    acc_max
end
acc_all
remove_candidate_F1
remove_candidate_F2
end