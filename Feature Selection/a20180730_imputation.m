function a20180730_imputation()
    data=load('step1_and_step2_data_alzheimer.txt');
    mark=-1;
    rows=size(data,1);
    cols=size(data,2);
    result=zeros(rows,cols);
    for i =1:cols
        l=data(:,i);
        result(:,i)=l;
        l(l==mark)=[];
        Mode=mode(l);
        result(result(:,i)==mark,i)=Mode;
    end
    
end