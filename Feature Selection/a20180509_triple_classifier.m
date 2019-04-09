function W=a20180509_triple_classifier(dataset,classcol)%直接根据dataset训练出一个三分类mapping，训练和测试都需要它
    acc=zeros(3,1);
    for i=0:2%3种情况，将另外两类归为负类。效果最好的两个，作为三分类器
        positive=dataset(,:);
        negative=dataset(,:);
        new_dataset_temp=[positive;negative];
        new_dataset=new_dataset_temp(randperm(size(new_dataset_temp,1)),:);
    end
end