function result=a20180307()
    %step1and2_data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    %step1data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data step1 only.xlsx');
    normal_data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data normal copy to 2556.xlsx');
    alzheimer_data_read=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data Alzheimer 2806.xlsx');
    fprintf('已读取所有数据\n');
    alzheimer_data_temp=alzheimer_data_read(randperm(2806),:);
    alzheimer_data=alzheimer_data_temp(1:2556,:);
    fprintf('已随机选取完2556个alzheimer的数据\n');
    candidate=[1:64];
    num_of_feat=64;
    T=64;
    temp_data=[normal_data;alzheimer_data];
    data=temp_data(randperm(5112),:); %打乱顺序
    fprintf('已打乱\n');
    data_class_col=size(data,2);
    a=zeros(64,1);
    for t=1:1
        svm_result_temp=0;
        for i=1:num_of_feat
            %Judge if the feature is in the candidate yet
            flag=0;
            if t~=1
                for j=1:t-1
                    if candidate(j)==i
                       flag=1;
                       break;
                    end
                end
            end
            if flag==1
               continue; 
            end
            %Choose the biggest as candidate
            if t==1
                data_temp=data(:,i);
            else
                data_temp=data(:,[candidate,i]);
            end
            temp=svc_train_and_test([data_temp,data(:,data_class_col)],t+1);
            a(i,1)=temp;
            if temp>svm_result_temp
               svm_result_temp=temp;
               newfeature=i;
            end
            [i,temp,newfeature,svm_result_temp]
        end
        %Add the best feature into candidate
        candidate=[candidate,newfeature]
    end
    a
    %Return the final result
    result=candidate;
end