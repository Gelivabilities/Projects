function result=a20180910()
    read=load('C:\Users\Administrator\Desktop\adataset.txt');
    data=read(:,1:6);
    data=mapminmax(data')';
    labels=read(:,7);
    %shuffler=randperm(514);
    %data=data(shuffler,:);
    %labels=labels(shuffler,:);
    data_set=dataset(data,labels);
    m=1000;
    t=0.001;
    eps=0.01;
    parameter=1;
    result=a20180902_evation_attack(data_set,m,t,eps,parameter);
end