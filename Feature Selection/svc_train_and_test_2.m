function [test_accuracy,test_accuracy_1,test_accuracy_2]=svc_train_and_test_2(train_data,test_data,classcol)
    %info
    train_cols=size(train_data,2);
	train_features=[train_data(:,1:(classcol-1)),train_data(:,(classcol+1):train_cols)];
    train_classes=train_data(:,classcol);
    test_cols=size(test_data,2);
	test_features=[test_data(:,1:(classcol-1)),test_data(:,(classcol+1):test_cols)];
    test_classes=test_data(:,classcol);
    
    %old
    %data=train_data;
    %rows=size(data,1);
    %cols=size(data,2);
	%features=[data(:,1:(classcol-1)),data(:,(classcol+1):cols)];
    %classes=data(:,classcol);
    %rand=RandomSeperate(0.5,1,rows);
    %trainds=dataset(features(rand==1,:),classes(rand==1,:));
    %testds=dataset(features(rand==0,:),classes(rand==0,:));
    
    %experiment
    trainds=dataset(train_features,train_classes);
    testds=dataset(test_features,test_classes);
    %train
    [W,J]=svc(trainds,proxm([],'r',1),1);
    %test
    svc_result=testds*W;
    Max_values=max(svc_result');
    Max_matrix=[Max_values;Max_values];
    r=svc_result'==Max_matrix;
    for t=1:size(r,2)
       if r(1,t)==r(2,t) %both rates are 0.5, random classifying
           m=floor(2*rand());
           r(1,t)=m;
           r(2,t)=1-m;
       end
    end
    classify_result=(r(2,:)-r(1,:)+ones())/2;
    temp=[(testds.nlab-ones()),classify_result'];%所有真实值与分类值
    temp1=temp(temp(:,1)==0,:);%正样本真实值与分类值
    temp2=temp(temp(:,1)==1,:);%负样本真实值与分类值
    test_accuracy=sum((testds.nlab-ones())==classify_result')/size(testds.data,1)%总accuracy
    %正样本accuracy
    test_accuracy_1=sum(temp1(:,1)==temp1(:,2))/size(temp1,1)
    %负样本accuracy
    test_accuracy_2=sum(temp2(:,1)==temp2(:,2))/size(temp2,1)
end