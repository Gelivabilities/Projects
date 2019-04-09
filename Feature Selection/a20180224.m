function result=a20180224()
    step1and2_data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    step1data=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data step1 only.xlsx');
    candidate=[];
    num_of_feat=46;
    T=46;
    data=step1data; %step1 and 2, can be changed into others
    data_class_col=size(data,2);
    for t=1:T
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
            if temp>svm_result_temp
               svm_result_temp=temp;
               newfeature=i;
            end
            [i,temp,newfeature,svm_result_temp]
        end
        %Add the best feature into candidate
        candidate=[candidate,newfeature]
    end
    %Return the final result
    result=candidate;
end