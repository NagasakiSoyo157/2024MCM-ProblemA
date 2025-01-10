%% 原始数据
clear
close all
clc
y=readmatrix("种群密度_原始数据.xlsx","Range",'B2:D121');
x=1:length(y);

%% 拟合曲线:鲑鱼
y(:,1)=fillmissing(y(:,1),'spline',1);

%% 填充缺失值：成体七鳃鳗
       a1 =       21.01 ;
       b1 =     0.01056 ;
       c1 =       2.258 ;
       a2 =       26.57 ;
       b2 =     0.06975 ;
       c2 =       1.749 ;
       a3 =       5.499 ;
       b3 =      0.4252 ;
       c3 =       1.004;
       a4 =       28.43  ;
       b4 =     0.07891  ;
       c4 =       4.284  ;
for i=1:length(x)
    if isnan(y(i,3))==1
        y(i,3)=a1*sin(b1*i+c1) + a2*sin(b2*i+c2) + a3*sin(b3*i+c3) + a4*sin(b4*i+c4);
    end
end

%% 填充缺失值:幼体七鳃鳗
       a1 =       167.4;
       b1 =     0.02781;
       c1 =      0.1354;
       a2 =        6458;
       b2 =      0.2372 ;
       c2 =      -4.131;
       a3 =       93.14;
       b3 =      0.1337 ;
       c3 =      0.3804 ; 
       a4 =        6513 ; 
       b4 =      0.2377 ; 
       c4 =       5.268 ; 

for i=1:length(x)
    if isnan(y(i,2))==1
        y(i,2)=a1*sin(b1*i+c1) + a2*sin(b2*i+c2) + a3*sin(b3*i+c3) + a4*sin(b4*i+c4);
    end
end

%%
y(y<0)=0;
figure
subplot(3,1,1)
plot(x,y(:,1));
legend('鲑鱼');
hold on
subplot(3,1,2)
plot(x,y(:,2));
legend('幼年七鳃鳗');
hold on
subplot(3,1,3)
plot(x,y(:,3));
legend('成年七鳃鳗');
hold on
