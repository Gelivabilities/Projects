function a20180918_gener()
    read_clean=load('C:\Users\Administrator\Desktop\adataset.txt');
    data_clean=mapminmax(read_clean(:,1:6)')';
    labels=read_clean(:,7);
    
%     %data加随机噪声
%     noise_size=1;%其他是0.5;%随机噪声大小
%     noise_rate=0.2;%pdf用0.5%其他是0.2;%噪声率
%     rows=size(data_clean,1);
%     cols=size(data_clean,2);
%     noise=(2*noise_size*rand(rows,cols)-noise_size*ones()).*(sign(rand(rows,cols)-1+noise_rate)+ones())/2;
%     %noise=repmat(mean(data),rows,1).*(rand(rows,cols)-0.5*ones()).*(sign(rand(rows,cols)-1+noise_rate)+ones())/2;
%     %data=data+noise;
%     
%     data_malignant=data_clean+noise;
    read_malignant=load('C:\Users\Administrator\Desktop\malignant.txt');
    data_malignant=mapminmax(read_malignant(:,1:6)')';
    
    para=1;
    num_of_epoch=2;
    mode='cross';
    algorithm='svc';
    acc=zeros(6,2);
    times=10;
    for time=1:times
        for i=1:6
            dataset_clean_i=dataset(data_clean(:,i),labels);
            dataset_malignant_i=dataset(data_malignant(:,i),labels);
            acc(i,:)=acc(i,:)+mean(Valid_same_data_different_features(dataset_clean_i,dataset_malignant_i,labels,num_of_epoch,mode,algorithm,para));
        end
    end
    acc/times
end