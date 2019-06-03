import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import cv2 as cv
from cv2 import *

dataset=pd.read_csv('C:/Users/Gelivability/Desktop/实验数据集整理/混合/cylinder-bands.csv')

#行列数
cols=np.size(dataset.iloc[0,:])-1
rows=np.size(dataset.iloc[:,0])

#数据和标签
data=dataset.iloc[:,0:cols]
cols_min=np.min(data.values,axis=0)
cols_max=np.max(data.values,axis=0)
data=(data.values-cols_min)/(cols_max-cols_min)#归一化
labels=dataset.iloc[:,cols].values

#合法、恶意样本
data_l=data[labels==1]
data_m=data[labels==-1]
l_rows=np.size(data_l[:,0])
m_rows=np.size(data_m[:,0])

#计算相关系数和EM距离，并将feature分布可视化
#特征选择得分变量
corr=np.zeros(cols)
em=np.zeros(cols)
#按feature计算
for i in range(cols):
    #相关系数
    corr[i]=abs(np.corrcoef(data[:,i],labels)[0,1])
    #EM距离
    parts=10#分段数目
    l_kde=np.zeros([1,parts])
    m_kde=np.zeros([1,parts])
    for j in range(parts):
        l_kde[0,j]=sum((data_l[:,i]>=j/parts)==(data_l[:,i]<(j+1)/parts))/l_rows
        m_kde[0,j]=sum((data_m[:,i]>=j/parts)==(data_m[:,i]<(j+1)/parts))/m_rows
        if j==parts-1:
            l_kde[0,j]+=sum(data_l[:,i]==1)/l_rows
            m_kde[0,j]+=sum(data_m[:,i]==1)/m_rows
    E1=np.asarray([np.hstack([1,l_kde[0]]).tolist()],np.float32)
    E2=np.asarray([np.hstack([1,m_kde[0]]).tolist()],np.float32)
    EM=cv.EMD(E1,E2,DIST_L1)[0]
    em[i]=EM
    #可视化
    s_l=pd.Series(data_l[:,i])
    s_m=pd.Series(data_m[:,i])
    plt.figure(figsize=(6,3))
    plt.title('feature: '+str(i+1)+', EMD='+str(EM))
    #if np.size(np.unique(data_l[:,i]))>1 and np.size(np.unique(data_m[:,i]))>1:
    #    pd.Series(data_l[:,i],name='legitimate').plot(kind='kde',color='b',legend=True)
    #    pd.Series(data_m[:,i],name='malignant').plot(kind='kde',color='r',legend=True)
    #else:
    df=pd.DataFrame(np.vstack([l_kde,m_kde]).T,columns=['legitimate','malignant'])
    df['legitimate'].plot(kind='bar',color='b',alpha=0.5,legend=True)
    df['malignant'].plot(kind='bar',color='r',alpha=0.5,grid=True,legend=True)
    
df_score=pd.DataFrame(np.vstack([corr,em]).T,columns=['Correlation','EMDistance'])
plt.figure(10,6)
df_score.plot(kind='bar',grid=True)