function a20180901_para_try()
    try_para=[1:5];
    acc_para=zeros(5,2);
    count=1;
    for i=try_para
        acc_para(count,:)=mean(a20180729_SVM(i));
        fprintf('para %.4f: acc1: %.4f, acc2:%.4f\n\n',i,acc_para(count,1),acc_para(count,2));
        count=count+1;
    end
    [try_para',acc_para]
end