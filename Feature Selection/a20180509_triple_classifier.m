function W=a20180509_triple_classifier(dataset,classcol)%ֱ�Ӹ���datasetѵ����һ��������mapping��ѵ���Ͳ��Զ���Ҫ��
    acc=zeros(3,1);
    for i=0:2%3������������������Ϊ���ࡣЧ����õ���������Ϊ��������
        positive=dataset(,:);
        negative=dataset(,:);
        new_dataset_temp=[positive;negative];
        new_dataset=new_dataset_temp(randperm(size(new_dataset_temp,1)),:);
    end
end