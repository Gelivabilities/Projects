function acc=a20180514_test_ovo(W_AB,W_AC,W_BC,test_data_3classes,epoch)
    test_data_AB=test_data_3classes(test_data_3classes(:,47)~=2,:);
    test_data_AC=test_data_3classes(test_data_3classes(:,47)~=1,:);
    test_data_BC=test_data_3classes(test_data_3classes(:,47)~=0,:);
    test_dataset_AB=dataset(test_data_AB(:,1:46),test_data_AB(:,47));
    test_dataset_AC=dataset(test_data_AC(:,1:46),test_data_AC(:,47));
    test_dataset_BC=dataset(test_data_BC(:,1:46),test_data_BC(:,47));
    matrix_AB=zeros(size(test_data_3classes,1),2);
    matrix_AC=zeros(size(test_data_3classes,1),2);
    matrix_BC=zeros(size(test_data_3classes,1),2);
    matrix_ABC=zeros(size(test_data_3classes,1),3);

    result_AB=test_dataset_AB*W_AB;
    result_AC=test_dataset_AC*W_AC;
    result_BC=test_dataset_BC*W_BC;
    result_ds_AB=test_data_AB*W_AB;
    result_ds_AC=test_data_AC*W_AC;
    result_ds_BC=test_data_BC*W_BC;
    matrix_AB(result_AB.nlab==1,1)=matrix_AB(result_AB.nlab==1,1)+ones();
    matrix_AB(result_AB.nlab==2,2)=matrix_AB(result_AB.nlab==2,2)+ones();
    matrix_AC(result_AC.nlab==1,1)=matrix_AC(result_AC.nlab==1,1)+ones();
    matrix_AC(result_AC.nlab==2,2)=matrix_AC(result_AC.nlab==2,2)+ones();
    matrix_BC(result_BC.nlab==1,1)=matrix_BC(result_BC.nlab==1,1)+ones();
    matrix_BC(result_BC.nlab==2,2)=matrix_BC(result_BC.nlab==2,2)+ones();
    
    matrix_
    
    %A, B, C
    matrix_ABC(:,1)=matrix_AB(:,1)+matrix_AC(:,1);
    matrix_ABC(:,2)=matrix_AB(:,2)+matrix_BC(:,1);
    matrix_ABC(:,3)=matrix_BC(:,2)+matrix_AC(:,2);
    [~,class_ABC_temp]=max(matrix_ABC');
    class_ABC=class_ABC_temp-ones();
    correct_or_wrong=test_data_3classes(:,47)==class_ABC';
    class_A_rows=find(test_data_3classes(:,47)==0);
    class_B_rows=find(test_data_3classes(:,47)==1);
    class_C_rows=find(test_data_3classes(:,47)==2);
    acc_A=sum(correct_or_wrong(class_A_rows,:))/size(class_A_rows,1);
    acc_B=sum(correct_or_wrong(class_B_rows,:))/size(class_B_rows,1);
    acc_C=sum(correct_or_wrong(class_C_rows,:))/size(class_C_rows,1);
    acc=[acc_A,acc_B,acc_C];
end