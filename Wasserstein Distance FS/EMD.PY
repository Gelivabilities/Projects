import numpy as np
import cv2 as cv
from cv2 import *
import matplotlib.pyplot as plt
import pandas as pd

print('图1到4的EM距离分别为：',end='')
#假设有3个value，恶意、合法样本比例不一样，下面都是假设的比例

#第1列是权重，剩下的列是每条直方图的值
#一般情况（按分布）
a=np.asarray([[1,0.2,0.6,0.3]],np.float32)
b=np.asarray([[1,0.4,0.2,0.4]],np.float32)

a1=np.asarray([[1,0.1,0.2,0.7]],np.float32)
b1=np.asarray([[1,0.3,0.5,0.2]],np.float32)

a2=np.asarray([[1,0.6,0.2,0.2]],np.float32)
b2=np.asarray([[1,0.5,0.2,0.3]],np.float32)

#极端情况
c=np.asarray([[1,0,0,1]],np.float32)
d=np.asarray([[1,0.4,0.6,0]],np.float32)

e=np.asarray([[1,0.5,0.3,0.2]],np.float32)
f=np.asarray([[1,0.5,0.3,0.2]],np.float32)

g=np.asarray([[1,0,0,1]],np.float32)
h=np.asarray([[1,1,0,0]],np.float32)

p=np.random.randn(2,100000)
p1=p[0]-1.5
p2=p[1]+0.8
p_min=np.min([np.min(p1),np.min(p2)])
p_max=np.max([np.max(p1),np.max(p2)])
p1=(p1-p_min)/(p_max-p_min)
p2=(p2-p_min)/(p_max-p_min)
l=np.zeros(20)
m=np.zeros(20)
for i in range(20):
    l[i]=sum((p1>=i/20)==(p1<(i+1)/20))/100000
    m[i]=sum((p2>=i/20)==(p2<(i+1)/20))/100000
    

A=pd.DataFrame(np.vstack([a[0,1:],b[0,1:]]).T,index=[1,2,3],columns=['malignant','legitimate'])
A.plot(kind='bar',grid=True,figsize=(4,2),title='EMD: '+str(cv.EMD(a,b,DIST_L1)[0]))

A1=pd.DataFrame(np.vstack([a1[0,1:],b1[0,1:]]).T,index=[1,2,3],columns=['malignant','legitimate'])
A1.plot(kind='bar',grid=True,figsize=(4,2),title='EMD: '+str(cv.EMD(a1,b1,DIST_L1)[0]))

A2=pd.DataFrame(np.vstack([a2[0,1:],b2[0,1:]]).T,index=[1,2,3],columns=['malignant','legitimate'])
A2.plot(kind='bar',grid=True,figsize=(4,2),title='EMD: '+str(cv.EMD(a2,b2,DIST_L1)[0]))

B=pd.DataFrame(np.vstack([c[0,1:],d[0,1:]]).T,index=[1,2,3],columns=['malignant','legitimate'])
B.plot(kind='bar',grid=True,figsize=(4,2),title='EMD: '+str(cv.EMD(c,d,DIST_L1)[0]))

C=pd.DataFrame(np.vstack([e[0,1:],f[0,1:]]).T,index=[1,2,3],columns=['malignant','legitimate'])
C.plot(kind='bar',grid=True,figsize=(4,2),title='EMD: '+str(cv.EMD(e,f,DIST_L1)[0]))

D=pd.DataFrame(np.vstack([g[0,1:],h[0,1:]]).T,index=[1,2,3],columns=['malignant','legitimate'])
D.plot(kind='bar',grid=True,figsize=(4,2),title='EMD: '+str(cv.EMD(g,h,DIST_L1)[0]))

plt.figure(figsize=(8,6))

#E=pd.DataFrame(np.vstack([l,m]).T)
#E.plot.bar()
E=pd.DataFrame(np.vstack([p1,p2]).T,columns=['malignant','legitimate'])
E1=np.asarray([np.hstack([1,l]).tolist()],np.float32)
E2=np.asarray([np.hstack([1,m]).tolist()],np.float32)
EM=cv.EMD(E1,E2,DIST_L1)[0]
E.plot.hist(alpha=0.5,grid=True,bins=100,title='EMD: '+str(EM))


#E=pd.Series(l,index=np.arange(20)/20)
#E.plot.bar(legend=True)
#F=pd.Series(m,index=np.arange(20)/20)
#F.plot.bar(legend=True)