x=[0,2,3,4.5,5,6.5,8,10,12.5,15,18.5,20,22,23.5]';
y=[0,10,15,20,25,30,35,40,45,50,55,57.5,60,62]';
z=10*rand*[0,10,15,20,25,30,35,40,45,50,55,57.5,60,62]';

X=[x.^2.*y.^2,x.*y.^2,x.^2.*y,x.*y,x.^2,x,ones(length(y),1)];
Z=z;
[b,bint,r,rint,stats] = regress(Z,X);
xt=linspace(1,25,50);yt=linspace(1,65,50);
zt=[];
for i=1:length(xt)
    for j=1:length(yt)
         zt(i,j)=b(1)*(xt(i).^2).*(yt(j).^2)+b(2)*xt(i).*yt(j).^2+b(3)*xt(i).^2.*yt(j)+b(4)*xt(i).*yt(j)+b(5)*xt(i).^2+b(6)*xt(i)+b(7);
    end
end
[XX,YY]=meshgrid(xt,yt);
ZZ=zt;
mesh(XX,YY,ZZ)
%hold on
%plot3(x',y',z','*')