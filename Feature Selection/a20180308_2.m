function a20180308_2()
    all_data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    normal_data=all_data(all_data(:,65)==0,:);
    alzheimer_data_read=all_data(all_data(:,65)==1,:);
    fprintf('�Ѷ�ȡ��������\n');
    alzheimer_data_temp=alzheimer_data_read(randperm(2806),:);
    alzheimer_data=alzheimer_data_temp(1:2556,:);
    fprintf('�����ѡȡ��2556��alzheimer������\n');
    temp_data=[normal_data;alzheimer_data];
    data=temp_data(randperm(5112),:); %����˳��
    fprintf('�Ѵ���\n');
    %all
    svc_train_and_test(data,65)
    %1
    data1=data(:,[16:27,29:33,35:42,44:65]);
    svc_train_and_test(data1,47)
    %2
    data2=data(:,[1:15,28,34,43,65]);
    svc_train_and_test(data2,19)
end