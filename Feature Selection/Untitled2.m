fun=@(x)sin(x).*x.^3; % fun�����ֱ��ʽ
% a,b������������
a = 0;
b = pi;
tol=1e-8; % tol�����־��ȣ�Ĭ��1e-6
% ��������ڵ�
syms x
p=sym2poly(diff((x^2-1)^(n+1),n+1))/(2^n*factorial(n));
tk=roots(p); % ����ڵ�
% �������ϵ��
Ak=zeros(n+1,1);
for i=1:n+1
xkt=tk;
xkt(i)=[];
pn=poly(xkt);
fp=@(x)polyval(pn,x)/polyval(pn,tk(i));
Ak(i)=quadl(fp,-1,1,tol); % ���ϵ��
end
% ���ֱ�����������[a,b]�任��[-1,1]
xk=(b-a)/2*tk+(b+a)/2;
% ������ֺ���fun��Ч��
fun=fcnchk(fun,'vectorize');
% �����������֮����ֺ�����ֵ
fx=fun(xk)*(b-a)/2;
% �������ֵ
ql=sum(Ak.*fx)
quadl(fun,0,pi) % ����MATLAB�ڲ����ֺ�������