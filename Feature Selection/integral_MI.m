function mi=integral_MI(x,y,d)
    xy=[x,y];
    n=size(xy,1);%��������
    %�õ�����Ϣ��x��yȡ��ͬ�����µ��ܶȣ�dΪ�ֶξ���
    minx=min(x);
    miny=min(y);
    maxx=max(x);
    maxy=max(y);
    x_range=[minx:d:maxx];
    y_range=[miny:d:maxy];
    %�����ܶȣ���ά���þ���棩
    p_xy=zeros(size(x_range,2)-1,size(y_range,2)-1);
    %��Ե�ܶȣ�һά���������棩
    p_x=zeros(size(x_range,2)-1);
    p_y=zeros(size(y_range,2)-1);
    for i=1:size(x_range,2)-1
       for j=1:size(y_range,2)-1
           x_condition=(xy(:,1)>=x_range(i) & xy(:,1)<=x_range(i+1));
           y_condition=(xy(:,2)>=y_range(j) & xy(:,2)<=y_range(j+1));
           p_xy(i,j)=size(xy(x_condition & y_condition),1)/n;
           if i==1
              p_y(j)=size(y(y_condition),1)/n; 
           end
       end
       p_x(i)=size(x(x_condition),1)/n;
    end
    mi=0;
    %�Ի���Ϣ��ʽ����
    for i=1:size(x_range,2)-1
       for j=1:size(y_range,2)-1
          if (p_xy(i,j)~=0 & p_x(i)~=0 & p_y(j)~=0)
            mi=mi+p_xy(i,j)*log(p_xy(i,j)/(p_x(i)*p_y(j)))/log(2); 
          end
       end
    end
end