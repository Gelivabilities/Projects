function result=a20180308()
    step1and2_data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    step1data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data step1 only.xlsx');
    candidate=[];
    num_of_feat=64;
    T=64;
    data=step1and2_data; %step1 and 2, can be changed into others
    data_class_col=size(data,2);
    for t=1:T
		% 5 rounds, get the min of total rank as candidate
		ranking=zeros(num_of_feat,5);
		feature_temp=zeros(num_of_feat,5);
		for round=1:5
			%svm_result_temp=0;
			for i=1:num_of_feat
				%Judge if the feature is in the candidate yet
				flag=0;
				if t~=1
					for j=1:t-1
						if candidate(j)==i
							ranking(i,round)=1000;%已成为候选子集的不再被候选
							feature_temp(i,round)=0;%accuracy用0代替，不被候选
						    flag=1;
						    break;
						end
					end
                end
				%Choose the biggest as candidate
				if t==1
					data_temp=data(:,i);
				else
					data_temp=data(:,[candidate,i]);
				end
				if flag~=1
                    feature_temp(i,round)=svc_train_and_test([data_temp,data(:,data_class_col)],t+1);
                end
			end
			ranking(:,round)=RankWithoutReply(feature_temp(:,round));
        end
        %total rank
        total_rank=sum(ranking')';
        %find out the best feature
        min_total_rank=min(total_rank);
        for j=1:size(total_rank,1)
            if total_rank(j,1)==min_total_rank
                newfeature=j;
                break;
            end
        end
        %Add the best feature into candidate
        candidate=[candidate,newfeature]
        %save data
        save_data=[ranking,total_rank];
        txt_name_1=strcat('t',num2str(t));
        txt_name_2=strcat('new_cand',num2str(newfeature));
        txt_name_3=strcat('acc');
        txt_name_cand=strcat(txt_name_1,txt_name_2);
        txt_name_acc=strcat(txt_name_1,txt_name_3);
        dlmwrite(strcat(txt_name_cand,'.txt'),save_data);
        dlmwrite(strcat(txt_name_acc,'.txt'),feature_temp);
    end
    %Return the final result
    result=candidate;
end