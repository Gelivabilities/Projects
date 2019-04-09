%% Main function of the course project
function pattern_classification()
    num_train_pos=360;
    num_train_neg=1005;
    num_test_pos=2043;
    num_test_neg=4832;
    fprintf('Initializing matrixes\n');
    tr_data_pos=zeros(num_train_pos,2330);
    tr_data_neg=zeros(num_train_neg,2330);
    te_data_pos=zeros(num_test_pos,2330);
    te_data_neg=zeros(num_test_neg,2330);
    fprintf('Matrix initialized\n');
    path_origin='C:\Users\Administrator\Desktop\PR_dataset\';
    for i=1:num_train_pos
        path=strcat(path_origin,'train\pos\');
        load_str=strcat(strcat(path,num2str(i-1)),'.txt');
        tr_data_pos(i,:)=load(load_str);
        if mod(i,1000)==0
            fprintf('%d positive training data loaded\n',i);
        end
    end
    for i=1:num_train_neg
        path=strcat(path_origin,'train\neg\');
        load_str=strcat(strcat(path,num2str(i-1)),'.txt');
        tr_data_neg(i,:)=load(load_str);
        if mod(i,1000)==0
            fprintf('%d negative training data loaded\n',i);
        end
    end
    for i=1:num_test_pos
        path=strcat(path_origin,'test\pos\');
        load_str=strcat(strcat(path,num2str(i-1)),'.txt');
        te_data_pos(i,:)=load(load_str);
        if mod(i,1000)==0
            fprintf('%d positive testing data loaded\n',i);
        end
    end
    for i=1:num_test_neg
        path=strcat(path_origin,'test\neg\');
        load_str=strcat(strcat(path,num2str(i-1)),'.txt');
        te_data_neg(i,:)=load(load_str);
        if mod(i,1000)==0
            fprintf('%d negative testing data loaded\n',i);
        end
    end
    tr_label_pos=zeros(num_train_pos,1);
    tr_label_neg=ones(num_train_neg,1);
    te_label_pos=zeros(num_test_pos,1);
    te_label_neg=ones(num_test_neg,1);
    train_all=[[tr_data_pos,tr_label_pos];[tr_data_neg,tr_label_neg]];
    test_all=[[te_data_pos,te_label_pos];[te_data_neg,te_label_neg]];
    train_dataset=dataset(train_all(:,1:2330),train_all(:,2331));
    test_dataset=dataset(test_all(:,1:2330),test_all(:,2331));
    
    %trying different parameters
    %for parameter=10:10:100 % unable to train at all
    %for parameter=1:10 % unable to train at all
    %for parameter=0.1:0.1:1 % unable to train at all
    %for parameter=5000:5000:50000 % unable to train when para>=25000
    %for parameter=1000:1000:25000 % perform not well when para>=2500
    %for parameter=100:100:1500 % unable to train when para<=500
    %for parameter=1500:50:2500 % 2350 is the best in this trial
        parameter=2350;
        fprintf('Parameter: %d\n',parameter);
        %Get the classifier in cross-validation of 2-fold training set
        [W1,W2]=Cross_validation(train_dataset,parameter);
        %test the classifier
        [pre,rec]=Get_Precision_and_Recall(test_dataset,W1,W2);
        fprintf('Test:\n')
        fprintf('\tPos\t\tNeg\t\tTotal\n');
        fprintf('Pre\t%.4f\t%.4f\t%.4f\n',pre(2),pre(3),pre(1));
        fprintf('Rec\t%.4f\t%.4f\t%.4f\n',rec(2),rec(3),rec(1));
        fprintf('**************************\n\n');
   %end
end
%% Function of cross-validation
function [W1,W2]=Cross_validation(data_set,parameter)
    data=data_set.data;
    classes=data_set.nlab-ones();
    %initialize variables
    rows=size(data,1);
    
    %shuffled data order for partition
    %original data's classes are like [0,0,...,0,1,1,...,1]
    shuffler=randperm(rows);
    shuff_data=data(shuffler,:);
    shuff_class=classes(shuffler,:);
    
    %training and testing
    for i=1:2
        %dataset partition
        step_length=floor(rows/2);
        if i==1
             te_tmp=step_length+1:rows;
             tr_tmp=1:step_length;
        else 
             te_tmp=1:step_length*(i-1);
             tr_tmp=step_length*(i-1)+1:rows;
        end
        %training data needs to be banlanced
        %positive data has about 1/3 size of the negative ones
        %copy the training data 3 times
        tr_data_tmp=[shuff_data(tr_tmp,:),shuff_class(tr_tmp,:)];
        tr_data_pos=tr_data_tmp(tr_data_tmp(:,2331)==0,:);
        tr_data_neg=tr_data_tmp(tr_data_tmp(:,2331)==1,:);
        tr_data=[repmat(tr_data_pos,3,1);tr_data_neg];
        
        %training and testing dataset
        tr_dataset=dataset(tr_data(:,1:2330),tr_data(:,2331));
        te_dataset=dataset(shuff_data(te_tmp,:),shuff_class(te_tmp,:));
        
        %training
        [W,~]=svc(tr_dataset,proxm([],'r',parameter),1);
        
        %classifying
        [pre,rec]=Get_Precision_and_Recall(te_dataset,W,W);
        
        %print out the result
        fprintf('cross-validation step %d:\n',i);
        fprintf('\tPos\t\tNeg\t\tTotal\n');
        fprintf('Pre\t%.4f\t%.4f\t%.4f\n',pre(2),pre(3),pre(1));
        fprintf('Rec\t%.4f\t%.4f\t%.4f\n',rec(2),rec(3),rec(1));
        fprintf('--------------------------\n');
        
        %return the classifiers
        if i==1
            W1=W;
        else
            W2=W;
        end
    end
end
%% This function is used to get precision and recall 
function [pre,rec]=Get_Precision_and_Recall(input_dataset,W1,W2)
    pre=zeros(1,3);
    rec=zeros(1,3);
    %get the avg output(probability) of two cross-validation classfiers
    test_result=(input_dataset*W1+input_dataset*W2)/2;
    Max_values=max(test_result');
    Max_matrix=[Max_values;Max_values];
    r=test_result'==Max_matrix;
    %both probabilities are 0.5, but a classification result is needed
    for t=1:size(r,2)
       if r(1,t)==r(2,t) 
           m=floor(2*rand());
           r(1,t)=m;
           r(2,t)=1-m;
       end
    end
    classify_result=(r(2,:)-r(1,:)+ones())/2;
    temp=[(input_dataset.nlab-ones()),classify_result'];
    precision_pos=temp(temp(:,2)==0,:);
    precision_neg=temp(temp(:,2)==1,:);
    actual_pos=temp(temp(:,1)==0,:);
    actual_neg=temp(temp(:,1)==1,:);
    row_pre_pos=size(precision_pos,1);
    row_pre_neg=size(precision_neg,1);
    row_act_pos=size(actual_pos,1);
    row_act_neg=size(actual_neg,1);
    row_all=size(input_dataset.data,1);
    
    %precision
    pre(1,2)=sum(precision_pos(:,1)==precision_pos(:,2))/row_pre_pos;
    pre(1,3)=sum(precision_neg(:,1)==precision_neg(:,2))/row_pre_neg;
    pre(1,1)=(pre(1,2)*row_pre_pos+pre(1,3)*row_pre_neg)/row_all;
    
    %recall
    rec(1,2)=sum(actual_pos(:,1)==actual_pos(:,2))/row_act_pos;
    rec(1,3)=sum(actual_neg(:,1)==actual_neg(:,2))/row_act_neg;
    rec(1,1)=(rec(1,2)*row_act_pos+rec(1,3)*row_act_neg)/row_all;
end