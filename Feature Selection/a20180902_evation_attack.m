function malignant_dataset=a20180902_evation_attack(data_set,m,t,eps,parameter,rate)
    [W,~]=svc(data_set,proxm([],'r',parameter),1);
    alphas=W.data{3};
    cols=size(data_set.data,2);
    %开始生成攻击数据集
    malignant_data=data_set.data;
    result_temp=data_set*W;
    result=result_temp.data;
    for j=1:size(data_set.data,1)
        if rand()<rate
            continue;
        end
        fprintf('\n%d ',j);
        %fprintf('\n\n%d：\n',j);
        delta_d=eps+1;
        i=0;
        temp=0;
        while i<m && delta_d>=eps
            if mod(i,1)==0
                fprintf('%d ',i);
                if mod(i,2000)==0
                    fprintf('\n');
                end
            end
            %temp相当于原文x(i-1)
            if i==0%第一轮temp用最开始的恶意样本（原正常样本加个随机噪声）
                temp=malignant_data(j,:)+0.01*(rand(1,cols)-0.005*ones(1,cols));
            end
            if result(j,1)>result(j,2)
                %fprintf('1');
                dgx=zeros(1,cols);
                for s=1:size(data_set.data,1)
                   dgx=dgx+alphas(s)*data_set.labels(s)*dk(temp,data_set.data(s,:),parameter); %SVM是RBF核
                end
                temp=malignant_data(j,:);
                malignant_data(j,:)=malignant_data(j,:)-t*dgx;
            else
                %fprintf('2');
                if i~=0
                    temp=malignant_data(j,:);
                end
                malignant_data(j,:)=malignant_data(j,:)-t*2*(temp-data_set.data(j,:));%距离是L2范数
            end
            %if mod(i,10)==0
            %    fprintf('\n');
            %end
            %此时的x相当于原文x(i)
            i=i+1;
            delta_d=c(malignant_data(j,:),data_set.data(j,:))-c(temp,data_set.data(j,:));
            fprintf('%.5f ',delta_d);
            %fprintf('%.4f ',delta_d);
            %if mod(i,10)==0
            %    fprintf('\n');
            %end
        end
    end
    malignant_dataset=dataset(malignant_data,data_set.labels);
end

function d=dk(x,xi,para)%核函数的梯度下降
    d=-2*para*exp(-para*(x-xi).^2).*(x-xi);
end

function distance=c(x1,x2)%L2范数，不开根号
    distance=sum((x1-x2).^2);
end