function a20180726()%filter特征选择
    fprintf('读取数据\n');
    
    %pdf数据集
    %pdf=load('C:\Users\Administrator\Desktop\data_pdf_large.txt');
    %data=mapminmax(pdf(:,1:114)')';
    %labels=sonar(:,115);
    
    %spambase数据集
    %spambase=load('C:\Users\Administrator\Desktop\spambase.txt');
    
    %按列归一化
    %data=mapminmax(spambase(:,1:57)')';
    %labels=spambase(:,58);
    
    %clean1数据集
    %clean1=load('C:\Users\Administrator\Desktop\sonar.txt');
    %data=clean1(:,1:60)/max(max(abs(clean1(:,1:60))));%归一化
    %labels=clean1(:,61);
    
    %----------NIPS 特征选择比赛 madelon数据集----------
    %data=load('C:\Users\Administrator\Desktop\NIPS madelon数据集\madelon_train.data');
    %data=mapminmax(data')';
    %labels=load('C:\Users\Administrator\Desktop\NIPS madelon数据集\madelon_train.labels');
    
    %read=load('C:\Users\Administrator\Desktop\data_pdf_large.txt');
    %data=mapminmax(read(:,1:114)')';
    %labels=read(:,115);
    
    %read=load('C:\Users\Administrator\Desktop\adataset.txt');
    %data=mapminmax(read(:,1:6)')';
    %labels=read(:,7);
    
    %read=load('C:\Users\Administrator\Desktop\数据集大全\wdbc.txt');
    %data=read(:,3:size(read,2));
    %labels=read(:,2);
    
    %data=xlsread('C:\Users\Administrator\Desktop\数据集大全\数据集文件夹\german（20维）\german_train_data.xlsx');
    %labels=xlsread('C:\Users\Administrator\Desktop\数据集大全\数据集文件夹\german（20维）\german_train_label.xlsx');
    %labels(labels(:,1)==-1,1)=0;
    
    %data_set=load('C:\Users\Administrator\Desktop\data.txt');
    %data=data_set(:,2:10);
    %labels=data_set(:,11);
    
    %data_load=load('C:\Users\Gelivability\Desktop\自制数据集.txt');
    %data=mapminmax(data_load(:,1:6)')';
    %labels=data_load(:,7);
    %feature_type_info=[1,1,0,0,0,0];
    
    %data_load=load('C:\Users\Gelivability\Desktop\实验数据集整理\离散\kr-vs-kp.csv');
    %data=mapminmax(data_load(:,1:36)')';
    %labels=data_load(:,37);
    %feature_type_info=zeros(1,36);
    
    %data_load=load('C:\Users\Gelivability\Desktop\实验数据集整理\离散\breast-cancer.csv');
    %data=mapminmax(data_load(:,1:9)')';
    %labels=data_load(:,10);
    %feature_type_info=[1 0 1 1 0 1 0 0 0];
    
    data_load=load('C:\Users\Gelivability\Desktop\实验数据集整理\混合\heart.dat');
    data=mapminmax(data_load(:,1:13)')';
    labels=data_load(:,14);
    feature_type_info=zeros(1,39);
    feature_type_info(:,[1,4,5,8,10,11,12])=1;
    
    labels(labels==2)=0;
    
    %clean1数据集
    %clean1=load('C:\Users\Administrator\Desktop\clean1.txt');
    %data=mapminmax(clean1(:,1:166)')';
    %labels=clean1(:,167);
    
    fprintf('读取完毕\n');
    num_of_feature=size(data,2);
    num_of_selecting_feature=1;%num_of_feature;
    para=1;%1是NIPS和PDF还有方同学的adataset的参数，%5是spambase的参数,%0.4是clean1参数
    k=5;%k=5;%patrick方法
    feature_subset=zeros(num_of_selecting_feature,1);
    for i=1:num_of_selecting_feature
        score=zeros(num_of_feature,1);
        max_score=-1;
        max_index=-1;
        for j=1:num_of_feature
            if sum(feature_subset==j)>0%跳过已选feature
               continue; 
            end
            if feature_type_info(j)==0
                mi=mutual_information(data(:,j),labels);
            else
                mi=integral_MI(data(:,j),labels,0.1);
            end
            %sec=security(data(:,j),labels,k);
            sec=our_method_0218(data(:,j),labels,0.2,feature_type_info(:,j));
            %sec=sqrt(security_distance(data(:,[feature_subset(1:i-1);j]),labels,k));
            score(j,1)=mi+para*sec;
            fprintf('Selecting: %d, feature: %d, Mutual information: %.4f, Security: %.4f, Score: %.4f\n',i,j,mi,sec,score(j,1));
            if score(j,1)>max_score
               max_score=score(j,1);
               max_index=j;
            end
        end
        feature_subset(i)=max_index;
        feature_subset(1:i)
    end
    %测试filter的效果(SVM训练+测试)
end

function corr=correlation(feature_data,labels)
    EX=mean(feature_data);
    EY=mean(labels);
    EXY=mean(feature_data.*labels);
    DX=var(feature_data);
    DY=var(labels);
    if DX==0 || DY==0
       corr=0; 
    else
       corr=abs((EXY-EX*EY)/sqrt(DX)/sqrt(DY));
    end
end

function sec=security(feature_data,labels,k)
    num_of_samples=size(feature_data,1);
    rate=zeros(num_of_samples,1);
    d=zeros(num_of_samples,num_of_samples);
    for i=1:num_of_samples
        for j=[1:i,i+1:num_of_samples-1]
            d(i,j)=sum((feature_data(i,:)-feature_data(j,:)).^2);
        end
    end
    for i=1:num_of_samples
        [~,d_sort_index]=sort(d(i,:));
        d_sort_index(d_sort_index==i)=[];
        d_sort_index_k=d_sort_index(:,1:k);
        current_label=labels(i);
        d_sort_k_labels=labels(d_sort_index_k);
        %d_sort_index
        %d_sort_k_labels
        rate(i)=sum(d_sort_k_labels==current_label)/k;
    end
    sec=mean(rate);
end

function sec=security_distance(feature_data,labels,k)
    num_of_samples=size(feature_data,1);
    avg_distance=zeros(num_of_samples,1);
    d=zeros(num_of_samples,num_of_samples);
    for i=1:num_of_samples
        for j=[1:i,i+1:num_of_samples]
            d(i,j)=sum((feature_data(i,:)-feature_data(j,:)).^2);
        end
    end
    for i=1:num_of_samples
        [d_sort_distance,d_sort_index]=sort(d(i,:));
        d_sort_index(d_sort_index==i)=[];
        d_sort_index_positive=d_sort_index(labels(d_sort_index)==1);
        d_sort_index_negative=d_sort_index(labels(d_sort_index)==-1);
        d_sort_distance(d_sort_index==i)=[];
        d_sort_distance_positive=d_sort_distance(d_sort_index_positive);
        d_sort_distance_negative=d_sort_distance(d_sort_index_negative);
        avg_distance(i)=sum(d_sort_distance_negative(1:k))/k;
    end
    sec=mean(avg_distance); 
end