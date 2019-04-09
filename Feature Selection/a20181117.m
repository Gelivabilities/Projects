function a20181117()
    read1=load('c:\users\Gelivability\desktop\step1.mat');
    read2=load('c:\users\Gelivability\desktop\step1_data.mat');
    read=[read2.data_and_labels,read1.data_and_labels(:,size(read1.data_and_labels,2))];
    %增加uncertain类,label要变化。1是certain，2是uncertain
    step2_needed=load('c:\users\Gelivability\desktop\tri_labels.txt');
    read(step2_needed==2,574)=2;
    rows=size(read,1);
    cols=size(read,2);
    %对data按列归一化并填补
    read(read==9)=NaN;
    data=mapminmax(read(:,1:cols-1)')';
    labels=read(:,cols);
    fprintf('正在用BPCA进行填补\n')
    data=BPCAfill(data);%填补，用BPCA进行填补
%       for i=76:cols-1
%           fprintf('\n%d\n',i);
%           [temp,~]=BPCAfill([data(:,i),labels]);
%           read(:,i)=temp(:,1);
%       end
    data(isnan(data))=0;
    %测试的参数
    para=6;
    acc=zeros(1,4);%第一列是总accuracy，后3列是不同class的accuracy
    epoch=10;
    for i=1:epoch
    %打乱，分成训练和测试
        shuffler=randperm(rows);
        data=data(shuffler,:);
        labels=labels(shuffler,:);
        train_data=data(1:rows/2,:);
        test_data=data(rows/2+1:rows,:);
        train_labels=labels(1:rows/2,:);
        test_labels=labels(rows/2+1:rows,:);
        %dataset
        train_dataset=dataset(train_data,train_labels);
        test_dataset=dataset(test_data,test_labels);
        %训练和测试
        [W,L]=ovr_svc_train(train_dataset,para,'r');
        acc(i,:)=ovr_svc_test(test_dataset,W,L);
    end
    acc
end