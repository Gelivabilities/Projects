%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Wpca,Xpca, mPca, eigNum] = PCA( X,  dimPara )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 此函数用来做PCA降维
%-input     X,输入样本按列堆积的矩阵: d * n ,d 为特征维数，n 为样本个数
%           dimPara, 初始目标降维数/保持的能量百分比
%-output    Wpca,散布矩阵的特征向量
%           Xpca(:,i)为X(:,i)在Wpca上的投影系数
%           mPca,所有样本的均值
%           eigNum, Xpca中降维后样本的维数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[d,n] = size( X );   % 样本矩阵的大小
% 总体均值
mPca = mean(X,2);    % 对X按行求均值，结果排成一列，则为一个d 维列向量

% 求散布矩阵St
Y = X - kron(ones(1,n), mPca);  % kron积，得到一个 d*n 均值矩阵，相当于把mPca列向量复制成 d*n 维

St = Y * Y.';                   % St＝d*d 维散布矩阵   

    % 求散布矩阵的特征向量，并选取d1个最大的特征值
    [V,D] = eig(St);            % 求出St的特征值矩阵D和和对应特征向量的矩阵V
    Ddiag = diag(D);            % 取特征值构成一个d维列向量
    Ddiag = Ddiag.';            % 变为d维行向量
    [Ddiag,Index] = sort(Ddiag, 'descend'); % 为取前d1个最大特征值，降序排列特征值
    d1 = DestDim( Ddiag, dimPara );  % 得到最终降维数
   
    % 求基向量Wpca以及X对Wpca的投影系数Xpca
    Wpca  = zeros(d1,d);        % 初始化基向量，这里的Wpca实际上为基向量的转置
    Xpca = zeros(d1,n);         % 初始化投影系数

    Wpca = V(:,Index(1:d1)).';  % 基向量Wpca为前d1个最大特征值对应的d维特征列向量构成的 d*d1 维投影矩阵，再转置后与Y乘得到投影系数Xpca
    Wpca = Wpca ./ ( sqrt(sum(Wpca.^2, 2)) * ones(1,size(Wpca,2)) );  % 把投影矩阵的每一行都除以该行的 2-norm(也就是通常的所有元素的平方求和再开根号),即标准化
    Xpca = Wpca * Y;            % 与Y乘得到 d1*n 维投影系数矩阵Xpca
    eigNum = d1;                % 得到最终降维数

   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function d1 = DestDim( Ddiag, dimPara )  % 得到最终降维数, Ddiag为降序排列的特征值行向量，dimPara为初始目标降维数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if dimPara <= 1
    sumEig0 = dimPara * sum(Ddiag);     % sum(Ddiag)为所有特征值之和
    sumEig = 0;
    d1 = 0;
    while  sumEig < sumEig0
        d1 = d1 + 1;   
        sumEig = sumEig + Ddiag(d1);    % sumEig为特征值累加 
    end 
else
    d1 = dimPara;  
end
% dimPara=0时，d1=0, Wpca＝zeros(0,d), Xpca=(0,n)
% dimPara<1时, 保持dimPara的能量，例如dimPara=0.9,保持90%
% dimPara>1时，d1=dimPara


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  此算法不能保证d1<＝n，即 d1>n 时也能降维到d1
%  d<=n时，自然有d1<=d<=n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%