fun=@(x)sin(x).*x.^3; % fun：积分表达式
% a,b：积分上下限
a = 0;
b = pi;
tol=1e-8; % tol：积分精度，默认1e-6
% 计算求积节点
syms x
p=sym2poly(diff((x^2-1)^(n+1),n+1))/(2^n*factorial(n));
tk=roots(p); % 求积节点
% 计算求积系数
Ak=zeros(n+1,1);
for i=1:n+1
xkt=tk;
xkt(i)=[];
pn=poly(xkt);
fp=@(x)polyval(pn,x)/polyval(pn,tk(i));
Ak(i)=quadl(fp,-1,1,tol); % 求积系数
end
% 积分变量代换，将[a,b]变换到[-1,1]
xk=(b-a)/2*tk+(b+a)/2;
% 检验积分函数fun有效性
fun=fcnchk(fun,'vectorize');
% 计算变量代换之后积分函数的值
fx=fun(xk)*(b-a)/2;
% 计算积分值
ql=sum(Ak.*fx)
quadl(fun,0,pi) % 调用MATLAB内部积分函数检验