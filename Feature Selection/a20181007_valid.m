function acc=a20181007_valid(datasets,classes,num_of_epoch,mode,algorithm,parameter)
    %initialize variables
    rows=size(datasets{1},1);
    num_of_k=size(datasets,2);
    for i=1:num_of_k
        if i==1
            acc_all={zeros(num_of_epoch,6)};
        else
            acc_all=[acc_all,zeros(num_of_epoch,6)];
        end
    end
    %shuffled data is needed in validation
    shuffler=randperm(rows);
    for data_num=1:num_of_k
        shuffled_data=datasets{data_num}(shuffler,:);
        shuffled_classes=classes(shuffler,:);
        
        a=1000;
        shuffled_data=shuffled_data(1:a,:);
        shuffled_data=shuffled_data(1:a,:);
        shuffled_classes=shuffled_classes(1:a,:);
        rows=a;
        
        %training and testing
        for i=1:num_of_epoch
            %dataset settings
            switch mode
                case 'LOO' 
                    train_dataset=dataset([shuffled_data(1:i-1,:);shuffled_data(i+1:rows,:)],[shuffled_classes(1:i-1,:);shuffled_classes(i+1:rows,:)]);
                    test_dataset=dataset(shuffled_data(i,:),shuffled_classes(i,:));
                case 'cross'
                    step_length=floor(rows/num_of_epoch);
                    switch i
                        case 1 %train set in the top
                            test_temp_1=[];
                            test_temp_2=step_length+1:rows;
                            train_temp=1:step_length;
                        case num_of_epoch %train set in the bottom
                            test_temp_1=1:step_length*(i-1);
                            test_temp_2=[];
                            train_temp=step_length*(i-1)+1:rows;
                        case i %train set in the middle
                            test_temp_1=1:step_length*(i-1);
                            test_temp_2=step_length*i+1:rows;
                            train_temp=step_length*(i-1)+1:step_length*i;
                    end
                    test_temp=[test_temp_1,test_temp_2];
                    test_dataset=dataset(shuffled_data(train_temp,:),shuffled_classes(train_temp,:));
                    train_dataset=dataset(shuffled_data(test_temp,:),shuffled_classes(test_temp,:));
            end  
            %train
            switch algorithm
                case 'svc' 
                    [W,~]=svc(train_dataset,proxm([],'r',parameter),1);%Use RBF, higher xigema
                case 'knnc' 
                    [W,~,~] = knnc(train_dataset,parameter);
                case 'neurc' 
                    W=neurc(train_dataset,parameter);
            end
            %test
            switch mode
                case 'LOO'
                    acc_all{data_num}(i,:)=[Get_Accuracy(train_dataset,W),Get_Accuracy_for_LOO(test_dataset,shuffled_classes(i,:),W)];
                case 'cross'
                    acc_all{data_num}(i,:)=[Get_Accuracy(train_dataset,W),Get_Accuracy(test_dataset,W)];
                    fprintf('%d: train: %.4f, test: %.4f\n',i,acc_all{data_num}(i,1),acc_all{data_num}(i,4));
            end
        end
    end
    acc=[];
    for i=1:num_of_k
        acc=[acc,acc_all{i}(:,4)];
    end
end 