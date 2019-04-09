function[M]=RandomSeperate(rate,x,y)%用于随机分成训练（KNN算法变成已知样本）和测试组的矩阵/向量（生成0和1）
    G=ones(x,y);
    %while(sum(sum(G))/(x*y)~=rate)
        G=sign(rand(x,y)-(1-rate)*ones())/2+0.5;
    %end
    M=G;
end