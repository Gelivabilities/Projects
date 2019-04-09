function a20180401()
    load=xlsread('C:\Users\Administrator\Desktop\PRTools\data\0414_step1.xlsx');
    %all, step1, step2 and information gain
    candidate=[1 5 34 8 7 9 10 39 27 19 6 43 13 33 4 18 11 45 23 29 31 32 30 28 15 36 17 22 35 3 26 25 40 38 21 24 20 2 37 14 12 41 46 16 44 42];
    num_of_feature=size(candidate,2);
    load=load(:,[candidate,47]);
    class_col=num_of_feature+1;
    num_of_round=20;
    %shuffle
    load=load(randperm(size(load,1)),:);
    dataset=load(1:1000,1:num_of_feature);
    classes=load(1:1000,class_col);    
    %test
    acc_all_round=zeros(num_of_feature*num_of_round,3);
    for i=1:num_of_feature
        for round=1:num_of_round
            data=dataset(:,1:i);
            %testing settings
            num_of_epoch=2;
            mode='cross';
            algorithm='svc';
            parameter=8;
            %exp
            acc_temp=mean(Validation(data,classes,num_of_epoch,mode,algorithm,parameter));%all
            acc_all_round((i-1)*num_of_round+round,:)=acc_temp(:,4:6);
            acc_all_round((i-1)*num_of_round+round,:)
            %b=mean(Validation(data(:,[16:27,29:33,35:42,44:64]),classes,num_of_epoch,mode,algorithm,parameter));%1
            %c=mean(Validation(data(:,[1:15,28,34,43]),classes,num_of_epoch,mode,algorithm,parameter));%2
            %[b;c;a]
        end
    end
    acc=zeros(num_of_feature,3);
    for i=1:num_of_feature
        front=1+(i-1)*num_of_round;
        ending=i*num_of_round;
        acc(i,:)=mean(acc_all_round(front:ending,:)); 
    end
    acc
end