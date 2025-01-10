% 本程序之目的为构建恒定模型，系本系列程序之核心
%% 设置初始参数
clear
close all
clc
y=readmatrix("种群密度_完整数据.xlsx",'Range','B2:E121');
copy=y;
[y,py]=mapminmax(y',0,1);
y=y';
x=1:length(y);
a1=0.7;%浮游生物的自然增长率
a2=0.5;%鱼类自然增长率
c1=0.6;%幼体七鳃鳗鱼的自然死亡率
c2=0.3;%成体七鳃鳗鱼的自然死亡率
r=0.4;%雌性个体占比
k=1000;%七鳃鳗平均每胎存活幼体个数
tspan=[1:length(y)];%预测时间长度：月
y0=y(1,:);%浮游生物、鱼类、七鳃鳗的初始种群密度
b11=0.1;%浮游生物被幼体七鳃鳗捕食率
b22=0.1;%鱼类被成体七鳃鳗捕食率
b12=0*b22;%浮游生物被成体七鳃鳗捕食率
d11=0.08;%幼体七鳃鳗捕食浮游生物系数
d22=0.08;%成体七鳃鳗捕食鱼类系数
d21=1*d11;%成体七鳃鳗捕食浮游生物系数

%% 求解
[t,z]=ode45(@lv,tspan,y0);
z=z';
z=mapminmax('reverse',z,py);
z=z';
y=copy;
z=z.*(max(y)./max(z));
y(:,2)=y(:,2)/100;
z(:,2)=z(:,2)/100;

%% 模型调整
st=z;
save stable.mat st;
subplot(4,1,1)
plot(t,z(:,1));
hold on
plot(t,y(:,1));
legend('浮游生物-理论','浮游生物-实际')
hold on
subplot(4,1,2)
plot(t,z(:,2));
hold on
plot(t,y(:,2));
legend('鲑鱼-理论','鲑鱼-实际')
hold on
subplot(4,1,3)
plot(t,z(:,3));
hold on
plot(t,y(:,3));
legend('幼体七鳃鳗-理论','幼体七鳃鳗-实际')
hold on
subplot(4,1,4)
plot(t,z(:,4));
hold on
plot(t,y(:,4));
legend('成体七鳃鳗-理论','成体七鳃鳗-实际')
hold off

%% 建立微分方程组（性别比恒定模型）
function dxdt = lv(t,x)
a1=evalin("base",'a1');
a2=evalin('base','a2');
c1=evalin('base','c1');
c2=evalin('base','c2');
if x(1)<=0
    x(1)=0;
end
r=evalin('base','r');
p=2*r;
k=evalin('base','k');
b11=evalin('base','b11');
b12=evalin('base','b12');
b22=evalin('base','b22');
d11=evalin('base','d11');
d21=evalin('base','d21');
d22=evalin('base','d22');
dxdt=zeros(4,1);
dxdt(1)=a1*(x(1)+0.5)-b11*x(1)*x(3)-b12*x(1)*x(4);%a1*2是为了保障浮游生物最低增长率
dxdt(2)=a2*x(2)-b22*x(2)*x(4);
dxdt(3)=d11*x(1)*x(3)-c1*x(3)+p*x(4);
dxdt(4)=d21*x(1)*x(4)+d22*x(2)*x(4)-c2*x(4);%-2*p*x(4);
end