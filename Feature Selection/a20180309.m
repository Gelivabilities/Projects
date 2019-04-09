function a20180309()
    %normal_data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data normal copy to 639.xlsx');
    %alzheimer_data_read=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data Alzheimer 2806.xlsx');
    all_data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    normal_data=all_data(all_data(:,65)==0,:);
    alzheimer_data_read=all_data(all_data(:,65)==1,:);
    fprintf('已读取所有数据\n');
    alzheimer_data_temp=alzheimer_data_read(randperm(2806),:);
    alzheimer_data=alzheimer_data_temp(1:2556,:);
    fprintf('已随机选取完2556个alzheimer的数据\n');
    % 1=normal (320*4=1280 training, 319testing), 2=alzheimer (1278 training, 1278 testing)
    temp1=normal_data(randperm(639),:);
    temp2=alzheimer_data(randperm(2556),:);
    train1=repmat(temp1(1:320,:),4,1);
    
    %试下适当加减一
    %add=RandomSeperate(0.03,1280,64);
    %minus=RandomSeperate(0.03,1280,64);
    %train1=[train1(:,1:64)+add-minus,train1(:,65)];
    
    train2=temp2(1:1278,:);
    test1=temp1(321:639,:);
    test2=temp2(1279:2556,:); 
    train_data_temp=[train1;train2];
    test_data_temp=[test1;test2];
    train_data=train_data_temp(randperm(2558),:);
    test_data=test_data_temp(randperm(1597),:);
    fprintf('已打乱\n');
    fprintf('已分为训练集和测试集\n');
    
    %all
    svc_train_and_test_2(train_data,train_data,65)
    %1
    train_data_1=train_data(:,[16:27,29:33,35:42,44:65]);
    test_data_1=test_data(:,[16:27,29:33,35:42,44:65]);
    svc_train_and_test_2(train_data_1,train_data_1,47)
    %2
    train_data_2=train_data(:,[1:15,28,34,43,65]);
    test_data_2=test_data(:,[1:15,28,34,43,65]);
    svc_train_and_test_2(train_data_2,train_data_2,19)
end