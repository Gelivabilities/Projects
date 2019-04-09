%安全性：计算恶意样本到一定比例的最近合法样本的平均距离，然后所有恶意样本得到的距离取平均值
function security=our_method_0218(data,labels,rate,feature_type_info)
    num_of_features=size(data,2);
    num_of_samples=size(data,1);
    num_of_malignant=sum(labels==1);
    num_of_legitimate=sum(labels==0);
    num_of_ordered=sum(feature_type_info==1);
    num_of_inordered=sum(feature_type_info==0);
    d=zeros(num_of_malignant,num_of_legitimate);%两个样本间的距离，行为合法样本，列为恶意样本
    malignant_data=data(labels==1,:);
    legitimate_data=data(labels==0,:);
    %无序部分预处理，生成取值比例“字典”
    %每个无序feature的序号
    f_inordered=[];
    for k=find(feature_type_info==0)
          f_inordered=[f_inordered,k];
    end
    v_dict={};
    count=1;
    for l=f_inordered%每个无序feature
        dict=unique(data(:,l));%无序feature的每个取值
        v_dict_feature=[dict,zeros(size(dict,1),1)];
        for m=dict'%每个取值
            labels_v=labels(data(:,f_inordered)==m);
            %feature取该值的合法样本数/feature取该值的样本总数
            v_dict_feature(count,2)=sum(labels_v==0)/size(labels_v,1);
            count=count+1;
        end
        %将占比进行归一化
        v_dict_feature_normalized=[v_dict_feature(:,1),mapminmax(v_dict_feature(:,2)')'];
        v_dict{length(v_dict)+1}=v_dict_feature_normalized;
    end
    %任意两个样本
    for i=1:num_of_malignant
        for j=1:num_of_legitimate
            %为有序feature赋予对应维度距离值
            d_temp=abs(malignant_data(i,:)-legitimate_data(j,:));
            d_ordered=d_temp(:,feature_type_info==1);%有序部分的距离，行向量

            %对无序的情况，为每个恶意样本到不同合法样本赋予这个维度上的距离值
            
            d_inordered=zeros(1,num_of_inordered);
            %一个个feature赋予距离
            for f=1:num_of_inordered
                feature_f=v_dict{f};
                rate1=feature_f(feature_f(:,1)==malignant_data(i,f_inordered(f)),2);
                rate2=feature_f(feature_f(:,1)==legitimate_data(j,f_inordered(f)),2);
                d_inordered(f)=1-abs(rate1-rate2);
            end
            %合并两个距离值，并计算距离
            d_all_dim=[d_ordered,d_inordered];
            d(i,j)=sqrt(sum(d_all_dim.^2));
        end
    end
    %----上面得到了每个恶意样本到每个合法样本的有效距离值----
    
    %我们方法：每个恶意样本，到最近p比例的合法样本的平均距离，然后所有恶意样本取平均值，作为feature子集的安全性
    %用上面的d(i,j)来做
    d_sort=sort(d')';%距离按合法样本排好序（因为是最近合法样本，不是最近恶意样本）
    d_sort_top=d_sort(:,1:floor(rate*num_of_malignant));%取最近的一定比例样本
    security=mean(mean(d_sort_top));
end