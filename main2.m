% 本程序之目的为绘制动静态模型之对比图
%%
clear
close all
clc
load dynamic.mat;
load stable.mat;
x=1:length(dy);
subplot(4,1,1)
plot(x,dy(:,1),"LineWidth",1.1,'Color',[0.24,0.35,0.67]);
hold on
plot(x,st(:,1),"LineWidth",1.1,"Color",[0.2 0.8 0.2]);
legend('dynamic','stable')
title('Plankton','FontSize',14);
ylabel('Cells/liter','FontSize',14)
hold on

subplot(4,1,2)
plot(x,dy(:,2),"LineWidth",1.1,'Color',[0.24,0.35,0.67]);
hold on
plot(x,st(:,2),"LineWidth",1.1,"Color",[0.2 0.8 0.2]);
legend('dynamic','stable')
title('Salmon','FontSize',14);
ylabel('amount/100m^2','FontSize',14)
hold on

subplot(4,1,3)
plot(x,dy(:,3),"LineWidth",1.1,'Color',[0.24,0.35,0.67]);
hold on
plot(x,st(:,3),"LineWidth",1.1,"Color",[0.2 0.8 0.2]);
legend('dynamic','stable')
title('Larval lamprey','FontSize',14);
ylabel('amount/100m^2','FontSize',14)
hold on

subplot(4,1,4)
plot(x,dy(:,4),"LineWidth",1.1,'Color',[0.24,0.35,0.67]);
hold on
plot(x,st(:,4),"LineWidth",1.1,"Color",[0.2 0.8 0.2]);
legend('dynamic','stable')
title('Adult lamprey','FontSize',14);
ylabel('amount/100m^2','FontSize',14)
sgtitle('Comparison of dynamic model and stable model')
hold off

%% 绘制性别比变化图
plot(x,rate,"LineWidth",1.1);
legend('sex rate')
ylabel('sex rate','FontSize',14)
title('sex rate change over time','FontSize',14);