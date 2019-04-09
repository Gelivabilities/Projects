function a20181205()
    data1=[0	0.45	0.51	0.39
            0.05	0.28	0.57	0.11
            0.12	0.53	0.58	0.27
            0.14	0.36	0.6	0.45
            0.21	0.22	0.61	0.63
            0.22	0.64	0.66	0.8
            0.23	0.45	0.69	0.6
            0.24	0.32	0.71	0.3
            0.28	0.1	0.7	0.44
            0.31	0.56	0.71	0.2
            0.32	0.4	0.72	0
            0.33	0.77	0.81	0.33
            0.35	0.26	0.82	0.63
            0.38	1	0.85	0.48
            0.4	0.48	0.87	0.11
            0.4	0.63	1	0.41];
    data2=[0.3325 	0.5317 	0.3717 	0.1418 
            0.1164 	0.1325 	0.7589 	0.9034 
            0.0679 	0.3617 	0.7073 	0.6767 
            0.5019 	0.7363 	0.9317 	0.9704 
            0.5157 	0.3715 	0.8467 	0.2557 
            0.2666 	0.7891 	0.9494 	0.1656 
            0.2259 	0.1420 	0.6451 	0.0762 
            0.2675 	0.8997 	0.8718 	0.3862 
            0.0419 	0.0722 	0.4129 	0.0999 
            0.3136 	0.1201 	0.8842 	0.6949 
            0.3137 	0.5936 	0.9623 	0.2268 
            0.2199 	0.0936 	0.6110 	0.4393 
            0.3029 	0.9632 	0.9103 	0.3121 
            0.1246 	0.6322 	0.6212 	0.3705 
            0.2829 	0.2119 	0.9573 	0.9950 
            0.3670 	0.0869 	0.8795 	0.8694 
            0.2854 	0.1097 	0.6909 	0.2892 
            0.2569 	0.7230 	0.8395 	0.6270 
            0.1525 	0.4491 	0.7110 	0.8593 
            0.0052 	0.4942 	0.8911 	0.2895 
            0.2988 	0.6806 	0.6845 	0.5534 
            0.3120 	0.8236 	0.9459 	0.4554 
            0.2528 	0.1204 	0.7635 	0.0951 
            0.2802 	0.5733 	0.6436 	0.4147 
            0.1744 	0.6525 	0.7211 	0.4491 
            0.2487 	0.4992 	0.8090 	0.9499 
            0.2211 	0.4228 	0.8544 	0.5716 
            0.1738 	0.0038 	0.8653 	0.2387 
            0.2195 	0.4917 	0.9570 	0.5715 
            0.3043 	0.3773 	0.9726 	0.8613 
            0.3938 	0.0971 	0.6922 	0.6994 
            0.0410 	0.7794 	0.7841 	0.0487 
            0.1904 	0.7498 	0.8482 	0.4697 
            0.2071 	0.8424 	0.8229 	0.0728 
            0.2958 	0.0482 	0.9387 	0.6121 
            0.3599 	0.5287 	0.9692 	0.2836 
            0.3965 	0.8889 	0.9691 	0.0400 
            0.2311 	0.7183 	0.7934 	0.0119 
            0.2101 	0.3514 	0.7893 	0.6850 
            0.0690 	0.4003 	0.6927 	0.7747 
            0.4423	0.534	0.5993	0.8717
            0.0985	0.3916	0.3525	0.3895
            0.1229	0.9708	0.3903	0.1737
            0.0379	0.0938	0.5429	0.7387
            0.1047	0.3957	0.5681	0.1073
            0.4122	0.8702	0.4971	0.4867
            0.1561	0.8922	0.5194	0.2675
            0.176	0.4414	0.5806	0.7893
            0.2737	0.6286	0.3369	0.7835
            0.3215	0.4136	0.5994	0.3612
            0.2517	0.6654	0.9816	0.2193
            0.087	0.1988	0.7354	0.5767
            0.0644	0.1757	0.9718	0.1562
            0.0768	0.5496	0.8141	0.3366
            0.1518	0.9157	0.8649	0.2682
            0.0006	0.793	0.8349	0.2314
            0.0752	0.2732	0.9778	0.0548
            0.2974	0.7554	0.9169	0.2507
            0.2445	0.8233	0.7885	0.7321
            0.0626	0.2438	0.7858	0.5562];
            data3_1=[0	0.45
            0.05	0.28
            0.12	0.53
            0.14	0.36
            0.21	0.22
            0.22	0.64
            0.23	0.45
            0.24	0.32
            0.28	0.1
            0.31	0.56
            0.32	0.4
            0.33	0.77
            0.35	0.26
            0.38	1
            0.4	0.48
            0.4	0.63
            0.81	0.33
            0.71	0.2
            0.71	0.3];
data3_2=[0.51	0.39
            0.57	0.11
            0.58	0.27
            0.6	0.45
            0.61	0.63
            0.66	0.8
            0.69	0.6
            0.7	0.44
            0.72	0
            0.82	0.63
            0.85	0.48
            0.87	0.11
            1	0.41];
data4_1=[0	0.45
        0.05	0.28
        0.12	0.53
        0.21	0.22
        0.22	0.64
        0.28	0.1
        0.31	0.56
        0.32	0.4
        0.33	0.77
        0.35	0.26
        0.38	1
        0.4	0.48
        0.4	0.63];
data4_2=[0.51	0.39
        0.57	0.11
        0.58	0.27
        0.6	0.45
        0.61	0.63
        0.66	0.8
        0.69	0.6
        0.71	0.3
        0.7	0.44
        0.71	0.2
        0.72	0
        0.81	0.33
        0.82	0.63
        0.85	0.48
        0.87	0.11
        1	0.41
        0.23	0.45
        0.24	0.32
        0.14	0.36];
%     plot(data1(:,1),data1(:,2),'o','MarkerFace','b');%class1
%     hold on
%     plot(data1(:,3),data1(:,4),'o','MarkerFace','r','MarkerEdge','r');%class2
    
%     plot(data3_1(:,1),data3_1(:,2),'o','MarkerFace','b');%class1
%     hold on
%     plot(data3_2(:,1),data3_2(:,2),'o','MarkerFace','r','MarkerEdge','r');%class2 
%     
%     plot(data4_1(:,1),data4_1(:,2),'o','MarkerFace','b');%class1
%     hold on
%     plot(data4_2(:,1),data4_2(:,2),'o','MarkerFace','r','MarkerEdge','r');%class2 
     
    labels=[zeros(16,1);ones(16,1)];
    D11=[data1(:,1);data1(:,3)];%第1个data，feature1
    D12=[data2(:,1);data2(:,3)];%第2个data，feature1
    D21=[data1(:,2);data1(:,4)];%第1个data，feature2
    D22=[data2(:,2);data2(:,4)];%第2个data，feature2
    %我们方法
    %[fatalness(D11),fatalness(D12),fatalness(D21),fatalness(D22)]%1
    %[our_approach(D11),our_approach(D12),our_approach(D21),our_approach(D22)]%2
    %[our_approach2(D11),our_approach2(D12),our_approach2(D21),our_approach2(D22)]%3
    %我们新方法
    D1_all_feature=[D11,D21];%第1个data
    D2_all_feature=[D12,D22];%第2个data
%     fatalness_1=our_new_approach(D1_all_feature,labels);
%     fatalness_2=our_new_approach(D2_all_feature,labels);
    fatalness_1=our_new_approach([data3_1;data3_2],[zeros(19,1);ones(13,1)]);
    fatalness_2=our_new_approach([data4_1;data4_2],[zeros(13,1);ones(19,1)]);
    fatalness_3=our_new_approach([data1(:,1:2);data1(:,3:4)],labels);
    [fatalness_1,fatalness_2,fatalness_3]
    %作者方法
    seccurity_1=min_distance([data3_1;data3_2],[zeros(19,1);ones(13,1)]);
    seccurity_2=min_distance([data4_1;data4_2],[zeros(13,1);ones(19,1)]);
    seccurity_3=min_distance([data1(:,1:2);data1(:,3:4)],labels);
    [seccurity_1,seccurity_2,seccurity_3]
end

%作者方法
function security=min_distance(data,labels)%假设是0正1负
    malignant_rows=sum(labels==1);
    legitimate_rows=sum(labels==0);
    min_d=zeros(malignant_rows,1);
    malignant_data=data(labels==1,:);
    legitimate_data=data(labels==0,:);
   
    for i=1:malignant_rows
        min_d_temp=inf;%最近合法样本距离
        for j=1:legitimate_rows
            d=sqrt(sum((malignant_data(i,:)-legitimate_data(j,:)).^2));
            if d<min_d_temp
                min_d_temp=d;
            end
        end
        min_d(i)=min_d_temp;
    end
    security=mean(min_d);
end

function distance=rmsd(row1,row2)
    %用均方根差来衡量两个样本的距离（均方根距离），使得距离不会受feature个数影响
    distance=sqrt(sum((row1-row2).^2)/size(row1,2));
end
%我们新方法
function fatalness=our_new_approach(data,labels)
    num_of_samples=size(data,1);
    num_of_pos_samples=sum(labels==0);
    num_of_neg_samples=sum(labels==1);
    num_of_fatal_samples=0;
    for i=1:num_of_samples
        %记录到正负样本的距离（当它是个栈）
        if labels(i)==0%正样本
            d_pos=zeros(num_of_pos_samples-1,1);
            d_neg=zeros(num_of_neg_samples,1);
        else%负样本
            d_pos=zeros(num_of_pos_samples,1);
            d_neg=zeros(num_of_neg_samples-1,1);
        end
        %正负样本下标（上面“栈”的栈顶坐标）
        pos=1;
        neg=1;
        %计算该样本到其他样本的距离
        range=(1:num_of_samples);
        range(range==i)=[];%被对比的对象不能包括自己
        for j=range
            if labels(j)==0%被对比样本是正样本
                d_pos(pos)=rmsd(data(i,:),data(j,:));
                pos=pos+1;
            else%被对比样本是负样本
                d_neg(neg)=rmsd(data(i,:),data(j,:));
                neg=neg+1;
            end
        end
        %计算该样本到两类样本的平均距离
        d_pos_mean=mean(d_pos);
        d_neg_mean=mean(d_neg);
        %利用threshold判断样本点是否安全（首先仍然要知道它是正样本还是负样本）
        if labels(i)==0%该样本点是正样本
            if d_pos_mean>d_neg_mean%离正样本太远，负样本太近
               num_of_fatal_samples=num_of_fatal_samples+1;
            end
        else%该样本点是负样本
            if d_neg_mean>d_pos_mean%离负样本太远，正样本太近
               num_of_fatal_samples=num_of_fatal_samples+1;
            end
        end
    end
    fatalness=num_of_fatal_samples/num_of_samples;
end

%我们方法
%1.均值倒数（危险性）
function risk=fatalness(data)
    rsk=zeros(60,1);
    for i=61:120%每个恶意样本
        d=zeros(30,1);
        for j=1:60%计算恶意样本到每个合法样本的距离
            d(j)=abs(data(i,1)-data(j,1));
        end
        rsk(i-60)=1/mean(d);
    end
    risk=mean(rsk);
end
%2.负倒数的指数幂的均值（安全性）
function s=our_approach(data)
    s_=zeros(60,1);
    for i=61:120%每个恶意样本
        e=zeros(60,1);
        for j=1:60%计算恶意样本到每个合法样本的距离
            d=abs(data(i,1)-data(j,1));
            if d==0
                e(j)=0;
            else
                e(j)=exp(-1/d);
            end
        end
        s_(i-60)=mean(e);
    end
    s=mean(s_);
end
%3.倒数的均值（危险性）
function risk=our_approach2(data)
    risk_=zeros(60,1);
    for i=61:120%每个恶意样本
        u=zeros(60,1);
        for j=1:60%计算恶意样本到每个合法样本的距离
            d=abs(data(i,1)-data(j,1));
            u=1/d;
        end
        risk_(i-60)=mean(u);
    end
    risk=mean(risk_);
end

%作者方法0
function security=feature_security(data)
    sec=zeros(60,1);
    for i=61:120%每个恶意样本
        temp_j=0;
        min_d=1;
        for j=1:60%计算恶意样本到所有合法样本的距离
            t=abs(data(i,1)-data(j,1));
            if t<min_d
                temp_j=j;
                min_d=t;
            end
        end
        %计算这个最近的合法样本到其他恶意样本的距离
        range=(61:120);
        range(range==i)=[];
        sec(i-60)=mean(abs(repmat(data(temp_j),59,1)-data(range,1)));
    end
    security=mean(sec);
end