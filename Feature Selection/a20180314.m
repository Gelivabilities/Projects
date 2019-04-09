function a20180314()
    load=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    %decrease alzheimer to balance
    healthy_exp=load(load(:,65)==0,:);
    alzheimer=load(load(:,65)==1,:);
    alzheimer_temp=alzheimer(randperm(size(alzheimer,1)),:);
    alzheimer_exp=alzheimer_temp(1:size(healthy_exp,1),:);
    dataset_temp=[healthy_exp;alzheimer_exp];
    load_data=dataset_temp(randperm(size(dataset_temp,1)),:);
    
    %load_data=load('C:\Users\Administrator\Desktop\PRTools\data\breast-cancer-wisconsin.data');
    %class1=load_data(load_data(:,11)==2,2:11);
    %class2=load_data(load_data(:,11)==4,2:11);
    %class=[class1;class2];
    %dataset=class(randperm(size(class,1)),:);
    
    %setting
    class_col=65;
    data=load_data(:,1:class_col-1);
    classes=load_data(:,class_col);
    for i=1:1
        num_of_epoch=10;
        mode='cross';
        algorithm='svc';
        xigema=8.5;
        parameter=sqrt(2*xigema^2);
        %exp
        %mean(Validation(data,classes,2,mode,algorithm,parameter))
        a=mean(Validation(data,classes,num_of_epoch,mode,algorithm,parameter));%all
        b=mean(Validation(data(:,[16:27,29:33,35:42,44:64]),classes,num_of_epoch,mode,algorithm,parameter));%1
        c=mean(Validation(data(:,[1:15,28,34,43]),classes,num_of_epoch,mode,algorithm,parameter));%2
        [b;c;a]
    end
end