function test_accuracy=svc_train_and_test(data,classcol)
    %info
    rows=size(data,1);
    cols=size(data,2);
	features=[data(:,1:(classcol-1)),data(:,(classcol+1):cols)];
    classes=data(:,classcol);
    %experiment
    temp=0;
    for i=1:1
        %random seperate into training set and testing set
        rand=RandomSeperate(0.5,1,rows);
        trainds=dataset(features(rand==1,:),classes(rand==1,:));
        testds=dataset(features(rand==0,:),classes(rand==0,:));
        %train
        [W,J]=svc(trainds,proxm([],'r',1),1);
        %test
        svc_result=testds*W;
        Max_values=max(svc_result');
        Max_matrix=[Max_values;Max_values];
        r=svc_result'==Max_matrix;
        classify_result=(r(2,:)-r(1,:)+ones())/2;
        a=[(testds.nlab-ones()),classify_result'];
        current_test_accuracy=sum((testds.nlab-ones())==classify_result')/size(testds.data,1);
        
        %t=[(testds.nlab-ones()),classify_result'];%所有真实值与分类值
        %temp1=t(t(:,1)==0,:);%正样本真实值与分类值
        %temp2=t(t(:,1)==1,:);%负样本真实值与分类值
        %正样本accuracy
        %test_accuracy_1=sum(temp1(:,1)==temp1(:,2))/size(temp1,1)
        %负样本accuracy
        %test_accuracy_2=sum(temp2(:,1)==temp2(:,2))/size(temp2,1)
        
        temp=temp+current_test_accuracy;
    end
    test_accuracy=temp/1;
end