function a20180221()
    data=xlsread('H:\文件大整合\编程\Matlab\PRTools\data\exp data.xlsx');
    step1data=xlsread('H:\文件大整合\编程\Matlab\PRTools\data\exp data step1 only.xlsx');
    %Step 1 and 2
    %fprintf('Step 1 and 2: ');
    %stp_1_2=svc_train_and_test(data,65)
    %Step 1 only
    %fprintf('Step 1 only: ');
    %step_1=svc_train_and_test(step1data,47)
    %top 10,20,30,40,50,60 features
    accuracy=zeros(64,1);
    for i =1:64
       fprintf('Top %d features: ',i);
       accuracy(i,1)=svc_train_and_test([data(:,1:i),data(:,65)],i+1); 
       fprintf('%f',accuracy(i,1));
    end
    [[1:64]',accuracy]
end