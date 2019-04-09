%��ȫ�ԣ��������������һ������������Ϸ�������ƽ�����룬Ȼ�����ж��������õ��ľ���ȡƽ��ֵ
function security=our_method_0218(data,labels,rate,feature_type_info)
    num_of_features=size(data,2);
    num_of_samples=size(data,1);
    num_of_malignant=sum(labels==1);
    num_of_legitimate=sum(labels==0);
    num_of_ordered=sum(feature_type_info==1);
    num_of_inordered=sum(feature_type_info==0);
    d=zeros(num_of_malignant,num_of_legitimate);%����������ľ��룬��Ϊ�Ϸ���������Ϊ��������
    malignant_data=data(labels==1,:);
    legitimate_data=data(labels==0,:);
    %���򲿷�Ԥ��������ȡֵ�������ֵ䡱
    %ÿ������feature�����
    f_inordered=[];
    for k=find(feature_type_info==0)
          f_inordered=[f_inordered,k];
    end
    v_dict={};
    count=1;
    for l=f_inordered%ÿ������feature
        dict=unique(data(:,l));%����feature��ÿ��ȡֵ
        v_dict_feature=[dict,zeros(size(dict,1),1)];
        for m=dict'%ÿ��ȡֵ
            labels_v=labels(data(:,f_inordered)==m);
            %featureȡ��ֵ�ĺϷ�������/featureȡ��ֵ����������
            v_dict_feature(count,2)=sum(labels_v==0)/size(labels_v,1);
            count=count+1;
        end
        %��ռ�Ƚ��й�һ��
        v_dict_feature_normalized=[v_dict_feature(:,1),mapminmax(v_dict_feature(:,2)')'];
        v_dict{length(v_dict)+1}=v_dict_feature_normalized;
    end
    %������������
    for i=1:num_of_malignant
        for j=1:num_of_legitimate
            %Ϊ����feature�����Ӧά�Ⱦ���ֵ
            d_temp=abs(malignant_data(i,:)-legitimate_data(j,:));
            d_ordered=d_temp(:,feature_type_info==1);%���򲿷ֵľ��룬������

            %������������Ϊÿ��������������ͬ�Ϸ������������ά���ϵľ���ֵ
            
            d_inordered=zeros(1,num_of_inordered);
            %һ����feature�������
            for f=1:num_of_inordered
                feature_f=v_dict{f};
                rate1=feature_f(feature_f(:,1)==malignant_data(i,f_inordered(f)),2);
                rate2=feature_f(feature_f(:,1)==legitimate_data(j,f_inordered(f)),2);
                d_inordered(f)=1-abs(rate1-rate2);
            end
            %�ϲ���������ֵ�����������
            d_all_dim=[d_ordered,d_inordered];
            d(i,j)=sqrt(sum(d_all_dim.^2));
        end
    end
    %----����õ���ÿ������������ÿ���Ϸ���������Ч����ֵ----
    
    %���Ƿ�����ÿ�����������������p�����ĺϷ�������ƽ�����룬Ȼ�����ж�������ȡƽ��ֵ����Ϊfeature�Ӽ��İ�ȫ��
    %�������d(i,j)����
    d_sort=sort(d')';%���밴�Ϸ������ź�����Ϊ������Ϸ������������������������
    d_sort_top=d_sort(:,1:floor(rate*num_of_malignant));%ȡ�����һ����������
    security=mean(mean(d_sort_top));
end