% 本程序之目的为讨论恒定模型下寄生虫与成体七鳃鳗的相互作用，动态模型相关内容请见main3.m
%% 设置初始参数
clear
close all
clc
y=readmatrix("种群密度_完整数据.xlsx",'Range','B2:E121');
g=zeros(length(y),1);
for i=1:length(i)
    g(i)=20+sin(0.5*i);
end
y=[y g];
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
d21=0.01*d11;%成体七鳃鳗捕食浮游生物系数
b5=0.005;
c5=0.016;
d5=0.001;

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
figure
subplot(2,1,1)
plot(t,z(:,4),"LineWidth",1.1,'Color',[252/255,170/255,103/255]);
a=area(z(:,4));
a.FaceColor=1/255*[250,200,205];
a.EdgeColor=1/255*[250,200,205];
legend('Adult lamprey')
ylabel('amount/100m^2','FontSize',14)
title('Adult lamprey','FontSize',14);
grid
hold on
subplot(2,1,2)
plot(t,z(:,5),"LineWidth",1.1);
b=area(z(:,5));
b.FaceColor=1/255*[219,249,244];
b.EdgeColor=1/255*[219,249,244];
legend('Parasite')
ylabel('amount/100m^2','FontSize',14)
title('Parasite','FontSize',14);
grid
sgtitle('Parasite and adult lamprey population curves--stable model')
hold on

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
b5=evalin('base','b5');
c5=evalin('base','c5');
d5=evalin('base','d5');
dxdt=zeros(5,1);
dxdt(1)=a1*(x(1)+0.5)-b11*x(1)*x(3)-b12*x(1)*x(4);%a1*2是为了保障浮游生物最低增长率
dxdt(2)=a2*x(2)-b22*x(2)*x(4);
dxdt(3)=d11*x(1)*x(3)-c1*x(3)+p*x(4);
dxdt(4)=d21*x(1)*x(4)+d22*x(2)*x(4)-c2*x(4)-b5*x(4)*x(5);
dxdt(5)=d5*x(4)*x(5)-c5*x(5);
end