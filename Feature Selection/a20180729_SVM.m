function acc=a20180729_SVM(parameter)%SVM 测试

    %data=xlsread('C:\Users\Administrator\Desktop\数据集大全\数据集文件夹\german（20维）\german_train_data.xlsx');
    %labels=xlsread('C:\Users\Administrator\Desktop\数据集大全\数据集文件夹\german（20维）\german_train_label.xlsx');
    %labels(labels(:,1)==-1,1)=0;
    %read=load('C:\Users\Administrator\Desktop\数据集大全\wdbc.txt');
    %data=read(:,3:size(read,2));
    %labels=read(:,2);
    
    %------------PDF ds---------------
    %read=load('C:\Users\Administrator\Desktop\data_pdf_large.txt');
    %data=mapminmax(read(:,1:114)')';
    %labels=read(:,115);
    
    %----------NIPS 特征选择比赛 madelon数据集----------
    %data=load('C:\Users\Administrator\Desktop\NIPS madelon数据集\madelon_train.data');
    %labels=load('C:\Users\Administrator\Desktop\NIPS madelon数据集\madelon_train.labels');
    
    %sonar数据集
    %sonar=load('C:\Users\Administrator\Desktop\sonar.txt');
    %data=mapminmax(sonar(:,1:60)')';
    %labels=sonar(:,61);
    
    %clean1数据集
    %clean1=load('C:\Users\Administrator\Desktop\sonar.txt');
    %data=clean1(:,1:60)/max(max(abs(clean1(:,1:60))));%归一化
    %labels=clean1(:,61);
    
    %labels(labels==-1)=0;
    %labels(labels==1)=-1;
    %labels(labels==0)=1;
    
    %spambase数据集
    %spambase=load('C:\Users\Administrator\Desktop\spambase.txt');
    %按列归一化
    %data=mapminmax(spambase(:,1:57)')';
    %labels=spambase(:,58);
    
    %read=load('C:\Users\Administrator\Desktop\data_pdf_large.txt');
    %data=mapminmax(read(:,1:114)')';
    %labels=read(:,115);
    
    %labels(labels==-1)=0;
    %labels(labels==1)=-1;
    %labels(labels==0)=1;
    
    %data=load('C:\Users\Administrator\Desktop\NIPS madelon数据集\madelon_train.data');
    %data=mapminmax(data')';
    %labels=load('C:\Users\Administrator\Desktop\NIPS madelon数据集\madelon_train.labels');
    
    %data=load('C:\Users\Administrator\Desktop\clean1.txt');
    %labels=data(:,167);
    %data=mapminmax((data(:,1:166))')';
    
    %data_load=load('C:\Users\Gelivability\Desktop\自制数据集.txt');
    %data=mapminmax(data_load(:,3)')';
    %labels=data_load(:,7);
    
    data_load=load('C:\Users\Gelivability\Desktop\实验数据集整理\混合\heart.dat');
    data=mapminmax(data_load(:,1:13)')';
    labels=data_load(:,14);
    feature_selection_order=load('C:\Users\Gelivability\Desktop\实验数据集整理\混合\heart_fs.txt');
    labels(labels==2)=-1;%负样本
    labels(labels==1)=1;%正样本
    
    feature_selection_order_correlation=feature_selection_order(:,1)';
    feature_selection_order_score=feature_selection_order(:,2)';
    
%     data=load('C:\Users\Administrator\Desktop\pdf.mat');
%     data=data.ans;
%     labels=data.labels;
%     data=mapminmax((data.data)')';
%     
%     features=load('C:\Users\Administrator\Desktop\pdfk=5.txt');
%     %k=7
%     feature_selection_order_correlation=features(:,1)';
%     feature_selection_order_score=features(:,2)';
    
    %------------------------PDF dataset-----------------------
    %feature_selection_order_correlation=[70 53 72 31 49 9 102 23 30 68 20 69 15 74 2 105 16 47 7 54 82 22 66 48 33 64 32 61 17 34 44 50 71 8 26 80 11 56 76 109 86 14 40 37 6 60 114 59 4 67 98 91 55 57 13 35 65 19 21 84 39 111 45 46 113 41 43 78 110 42 96 62 28 95 92 97 83 100 38 75 3 87 58 79 112 36 108 12 25 63 77 107 81 104 1 51 90 52 106 103 101 93 89 27 94 88 29 85 5 24 18 10 99 73];
    %k=3
    %feature_selection_order_score=[70 30 53 72 9 31 49 102 23 54 20 69 15 16 68 61 44 32 74 50 14 22 19 60 113 13 43 84 45 110 21 39 2 98 80 105 59 57 47 58 7 38 35 111 112 8 86 96 82 66 4 48 33 64 63 71 78 83 42 17 40 97 34 25 87 41 28 75 26 89 67 91 11 56 76 109 92 55 104 51 90 95 108 77 37 6 1 81 114 103 62 5 107 88 94 18 85 12 65 46 79 3 10 100 29 52 36 106 99 101 93 73 27 24];
    %k=5
    %feature_selection_order_score=[70 53 72 31 49 9 102 23 30 54 20 69 15 68 16 61 74 32 44 50 14 22 19 60 113 13 84 43 45 21 110 80 39 57 98 59 2 58 105 38 111 47 86 8 7 35 112 4 97 96 82 25 63 40 66 83 71 78 48 95 33 64 42 89 17 87 34 67 41 75 91 28 62 55 26 109 11 81 56 76 77 92 104 51 90 108 1 37 6 103 114 88 12 5 107 94 18 85 65 79 46 3 10 52 29 100 106 99 36 73 101 93 27 24];
    %feature_selection_order_correlation=[28 23 8 21 3 24 1 4 7 27 6 26 11 13 14 22 2 25 29 18 5 9 30 16 17 20 15 10 12 19];
    
    
    %老师的方法
    %feature_selection_order_score=[23 28 21 8 24 3 1 7 4 27 14 13 11 26 6 22 2 18 29 25 5 17 30 9 16 20 15 19 10 12];%para=2.5

    %feature_selection_order_score=[28 23 21 8 24 3 1 4 7 27 6 26 14 11 13 22 2 25 29 18 5 30 9 16 17 20 15 10 12 19];%para=0.5
    
    num_of_feature=size(data,2);
    
    %data加随机噪声
    noise_size=1;%其他是0.5;%随机噪声大小
    noise_rate=0.1;%pdf用0.5%其他是0.2;%噪声率
    rows=size(data,1);
    cols=size(data,2);
    %noise=(2*noise_size*rand(rows,cols)-noise_size*ones()).*(sign(rand(rows,cols)-1+noise_rate)+ones())/2;
    %noise=repmat(mean(data),rows,1).*(rand(rows,cols)-0.5*ones()).*(sign(rand(rows,cols)-1+noise_rate)+ones())/2;
    %data=data+noise;
    
    %用取值代替noise
    unique_values=unique(data);
    for i=1:size(data,1)
        for j=1:size(data,2)
            if rand()>0.7
               temp=unique_values(randperm(size(unique_values,1)));
               %data(i,j)=temp(1);
            end
        end
    end
    
    data_set=[data,labels];
    class_col=num_of_feature+1;
    
    %打乱并平衡数据集（这次正样本多，标签反过来）
    positive=data_set(data_set(:,class_col)==-1,:);
    negative=data_set(data_set(:,class_col)==1,:);
    negative_temp=negative(randperm(size(negative,1)),:);
    negative_exp=negative_temp(1:size(positive,1),:);
    dataset_temp=[positive;negative_exp];
    dataset=dataset_temp(randperm(size(dataset_temp,1)),:);
    classes=dataset(:,class_col);  
    
    %test
    acc=zeros(num_of_feature,2);
    for i=1:num_of_feature
        input_data_correlation=dataset(:,feature_selection_order_correlation(:,1:i));
        input_data_score=dataset(:,feature_selection_order_score(:,1:i));
        %testing settings
        num_of_epoch=2;
        mode='cross';
        algorithm='svc';
        %exp
        acc(i,:)=mean(Valid_same_data_different_features(input_data_correlation,input_data_score,classes,num_of_epoch,mode,algorithm,parameter));%all
        acc(i,:)
    end
    %acc
end