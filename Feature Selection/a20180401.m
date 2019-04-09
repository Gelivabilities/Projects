function a20180401()
    load=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    %all, step1, step2 and information gain
    candidate_all=[63 18 16 21 19 20 41 17 42 64 45 1 5 13 49 57 12 51 47 29 37 9 14 54 60 59 2 39 36 32 6 38 40 8 43 56 11 61 50 24 55 44 15 7 46 3 4 53 35 58 30 28 34 10 48 62 31 23 33 27 52 25 26 22];
    candidate_step1=[63 45 49 40 16 19 21 41 42 20 64 51 54 57 61 32 39 37 44 22 59 56 38 24 36 55 30 60 46 48 53 52 29 35 62 58 47 18 50 23 25 17 31 33 27 26];
    candidate_step2=[34 12 6 5 28 4 15 43 9 3 1 13 8 7 2 14 11 10];
    candidate_info=[1:64];
    candidate=candidate_info;
    num_of_feature=size(candidate,2);
    load=load(:,[candidate,65]);
    class_col=num_of_feature+1;
    %shuffle and balance
    healthy_exp=load(load(:,class_col)==0,:);
    alzheimer=load(load(:,class_col)==1,:);
    alzheimer_temp=alzheimer(randperm(size(alzheimer,1)),:);
    alzheimer_exp=alzheimer_temp(1:size(healthy_exp,1),:);
    dataset_temp=[healthy_exp;alzheimer_exp];
    dataset=dataset_temp(randperm(size(dataset_temp,1)),:);
    classes=dataset(:,class_col);    
    %test
    acc=zeros(num_of_feature,3);
    for i=1:num_of_feature
        data=dataset(:,1:i);
        %testing settings
        num_of_epoch=5;
        mode='cross';
        algorithm='svc';
        parameter=8;
        %exp
        acc_temp=mean(Validation(data,classes,num_of_epoch,mode,algorithm,parameter));%all
        acc(i,:)=acc_temp(:,4:6);
        acc(i,:)
        %b=mean(Validation(data(:,[16:27,29:33,35:42,44:64]),classes,num_of_epoch,mode,algorithm,parameter));%1
        %c=mean(Validation(data(:,[1:15,28,34,43]),classes,num_of_epoch,mode,algorithm,parameter));%2
        %[b;c;a]
    end
    acc
end