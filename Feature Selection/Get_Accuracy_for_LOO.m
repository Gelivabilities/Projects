function acc=Get_Accuracy_for_LOO(test_dataset,class,W)
    acc=zeros(1,3);
    test_result=test_dataset*W;
    Max_values=max(test_result');
    Max_matrix=[Max_values;Max_values];
    r=test_result'==Max_matrix;
    for t=1:size(r,2)
       if r(1,t)==r(2,t) %both rates are 0.5, random classifying
           m=floor(2*rand());
           r(1,t)=m;
           r(2,t)=1-m;
       end
    end
    classify_result=(r(2,:)-r(1,:)+ones())/2;
    temp=[class,classify_result'];%所有真实值与分类值
    temp1=temp(temp(:,1)==0,:);%正样本真实值与分类值
    temp2=temp(temp(:,1)==1,:);%负样本真实值与分类值
    acc(1,1)=sum(class==classify_result')/size(test_dataset.data,1);%所有样本accuracy
    acc(1,2)=sum(temp1(:,1)==temp1(:,2))/size(temp1,1);%正样本accuracy
    acc(1,3)=sum(temp2(:,1)==temp2(:,2))/size(temp2,1);%负样本accuracy
end