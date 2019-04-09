function result=a20180328()
    %load data
    load=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    
    %num of feature
    num_of_feature=64;

    %feature selection settings
    candidate=[];
    T=64;
    get_round=40;
   
    %SVM settings
    num_of_epoch=2;
    mode='cross';
    algorithm='svc';
    parameter=8;
    
    %Start feature selection
    for t=size(candidate,2)+1:T
        
        candidate
		% Get the avg accuracy of all rounds,the highest one is the candidate
		feature_accuracy=zeros(num_of_feature,get_round);
		for round=1:get_round
            fprintf('\nRound %d:\n',round);
            %balance and shuffle data
            healthy_exp=load(load(:,65)==0,:);
            alzheimer=load(load(:,65)==1,:);
            alzheimer_temp=alzheimer(randperm(size(alzheimer,1)),:);
            alzheimer_exp=alzheimer_temp(1:size(healthy_exp,1),:);
            dataset_temp=[healthy_exp;alzheimer_exp];
            load_data=dataset_temp(randperm(size(dataset_temp,1)),:);    
            data=load_data(:,1:num_of_feature); %all feature
            %data=load_data(:,[16:27,29:33,35:42,44:64]);%step1 only
            %data=load_data(:,[1:15,28,34,43]);%step2 only
            
            classes=load_data(:,size(load_data,2));
            %Judge if the feature is in the candidate yet
			for i=1:num_of_feature
				flag=0;
				if t~=1
					for j=1:t-1
						if candidate(j)==i
						    flag=1;
						    break;
						end
					end
                end
                %jump out if it is candidate
                if flag==1
                    continue;
                end
                
				%Choose the best as candidate
				if t==1
					data_temp=data(:,i);
				else
					data_temp=data(:,[candidate,i]);
                end
                acc_all=mean(Validation_Test_Only(data_temp,classes,num_of_epoch,mode,algorithm,parameter));
                feature_accuracy(i,round)=acc_all(:,1);%只取所有样本accuracy
                fprintf('Num %d: Feature:%d %.4f, ',t,i,acc_all(:,1));
                if mod(i,5)==0
                    fprintf('\n');
                end
            end
        end
        
        %Add the best feature into candidate
        avg_acc=mean(feature_accuracy')';
        max_acc=0;
        for temp=1:num_of_feature
            if avg_acc(temp)>max_acc
                max_acc=avg_acc(temp);
                new_feature=temp;
            end
        end
        candidate=[candidate,new_feature];
        %save data
        txt_name_1=strcat('t',num2str(t));
        txt_name_3=strcat('acc');
        txt_name_acc=strcat(txt_name_1,txt_name_3);
        dlmwrite(strcat(txt_name_acc,'.txt'),feature_accuracy);
    end
    %Return the final result
    result=candidate;
end