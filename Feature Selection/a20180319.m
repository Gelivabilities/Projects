function a20180319()
    load=xlsread('C:\Users\Administrator\Desktop\PRTools\data\exp data.xlsx');
    %decrease alzheimer to balance
    healthy_exp=load(load(:,65)==0,:);
    alzheimer=load(load(:,65)==1,:);
    alzheimer_temp=alzheimer(randperm(size(alzheimer,1)),:);
    alzheimer_exp=alzheimer_temp(1:size(healthy_exp,1),:);
    dataset_temp=[healthy_exp;alzheimer_exp];
    dataset=dataset_temp(randperm(size(dataset_temp,1)),:);
    %load_data=load('C:\Users\Administrator\Desktop\PRTools\data\breast-cancer-wisconsin.data');
    %class1=load_data(load_data(:,11)==2,2:11);
    %class2=load_data(load_data(:,11)==4,2:11);
    %class=[class1;class2];
    %dataset=class(randperm(size(class,1)),:);
    
    %setting
    class_col=65;
    data=dataset(:,1:class_col-1);
    classes=dataset(:,class_col);
    for i=1:20
        %num_of_epoch=5*i;
        mode='cross';
        algorithm='neurc';
        parameter=10*i;
        %exp
        %mean(Validation(data,classes,2,mode,algorithm,parameter))
        a=mean(Validation(data,classes,2,mode,algorithm,parameter));%all
        b=mean(Validation(data(:,[16:27,29:33,35:42,44:64]),classes,2,mode,algorithm,parameter));%1
        c=mean(Validation(data(:,[1:15,28,34,43]),classes,2,mode,algorithm,parameter));%2
        i
        [b;c;a]
    end
end