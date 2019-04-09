function a20181117()
    read1=load('c:\users\Gelivability\desktop\step1.mat');
    read2=load('c:\users\Gelivability\desktop\step1_data.mat');
    read=[read2.data_and_labels,read1.data_and_labels(:,size(read1.data_and_labels,2))];
    %����uncertain��,labelҪ�仯��1��certain��2��uncertain
    step2_needed=load('c:\users\Gelivability\desktop\tri_labels.txt');
    read(step2_needed==2,574)=2;
    rows=size(read,1);
    cols=size(read,2);
    %��data���й�һ�����
    read(read==9)=NaN;
    data=mapminmax(read(:,1:cols-1)')';
    labels=read(:,cols);
    fprintf('������BPCA�����\n')
    data=BPCAfill(data);%�����BPCA�����
%       for i=76:cols-1
%           fprintf('\n%d\n',i);
%           [temp,~]=BPCAfill([data(:,i),labels]);
%           read(:,i)=temp(:,1);
%       end
    data(isnan(data))=0;
    %���ԵĲ���
    para=6;
    acc=zeros(1,4);%��һ������accuracy����3���ǲ�ͬclass��accuracy
    epoch=10;
    for i=1:epoch
    %���ң��ֳ�ѵ���Ͳ���
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
        %ѵ���Ͳ���
        [W,L]=ovr_svc_train(train_dataset,para,'r');
        acc(i,:)=ovr_svc_test(test_dataset,W,L);
    end
    acc
end