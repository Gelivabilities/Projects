function accuracy=a20180528_system_test(dataset4,dataset2,dataset4_bak,dataset2_bak,W_C1_1,W_C1_2,W_C2,type,num_of_f1,num_of_all)

    ds4_temp=dataset4;
    ds4_temp(dataset4(:,num_of_f1+1)==2,num_of_f1+1)=0;
    ds4_temp(dataset4(:,num_of_f1+1)==3,num_of_f1+1)=1;
    ds4=dataset(ds4_temp(:,1:num_of_f1),ds4_temp(:,num_of_f1+1));%只有正常和痴呆两类
    
    certain_or_not=Get_Accuracy(ds4,W_C1_1);
    
    result_C1_1=ds4*W_C1_1;
    ds_certain_temp=dataset2_bak(result_C1_1.nlab==1,[1:num_of_f1,num_of_all+1]);
    ds_uncertain_temp=dataset2_bak(result_C1_1.nlab==2,:);
    ds_certain=dataset(ds_certain_temp(:,1:num_of_f1),ds_certain_temp(:,num_of_f1+1));
    ds_uncertain=dataset(ds_uncertain_temp(:,1:num_of_all),ds_uncertain_temp(:,num_of_all+1));
    
    certain_normal_or_alzheimer=Get_Accuracy(ds_certain,W_C1_2);
    uncertain_normal_or_alzheimer=Get_Accuracy(ds_uncertain,W_C2);
    
    certain_normal=certain_or_not(2)*certain_normal_or_alzheimer(2);
    certain_alzheimer=certain_or_not(2)*certain_normal_or_alzheimer(3);
    uncertain_normal=certain_or_not(3)*uncertain_normal_or_alzheimer(2);
    uncertain_alzheimer=certain_or_not(3)*uncertain_normal_or_alzheimer(3);
    total4=(certain_normal*1747+certain_alzheimer*116+uncertain_normal*319+uncertain_alzheimer*1403)/3585;
    if type==4
        accuracy=[certain_normal,uncertain_normal,certain_alzheimer,uncertain_alzheimer,total4];
    end
    r1=1747/2066;
    r2=319/2066;
    r3=116/1519;
    r4=1403/1519;
    acc_normal=r1*certain_normal_or_alzheimer(2)+r2*uncertain_normal_or_alzheimer(2);
    acc_alzheimer=r3*certain_normal_or_alzheimer(3)+r4*uncertain_normal_or_alzheimer(3);
    total2=(acc_normal*2066+acc_alzheimer*1519)/3585;
    if type==2
        accuracy=[acc_normal,acc_alzheimer,total2];
    end
end
