function[M]=RandomSeperate(rate,x,y)%��������ֳ�ѵ����KNN�㷨�����֪�������Ͳ�����ľ���/����������0��1��
    G=ones(x,y);
    %while(sum(sum(G))/(x*y)~=rate)
        G=sign(rand(x,y)-(1-rate)*ones())/2+0.5;
    %end
    M=G;
end