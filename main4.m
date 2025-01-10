% 本程序之目的为计算各物种的生物量和基于生物量的相对丰度，据此计算香浓指标并绘图
%% 恒定模型
%斯科尔夫河平均水深：2.5米
%大西洋鲑鱼的平均质量：3.6kg
%七鳃鳗成体平均质量：0.311kg
%七鳃鳗幼体平均质量：10g
%所有生物量单位统一为kg/100平米水域
clear
clc
load stable.mat;
load dynamic.mat;
plankton=st(:,1);
plankton=plankton*250000*0.000001;%设定浮游生物平均质量为1mg
salmon=st(:,2);
salmon=3.6*salmon;
larval=st(:,3);
larval=larval*0.01;
adult=st(:,4);
adult=adult*0.311;
x=1:120;
%{
plot(x,plankton);
hold on
plot(x,salmon);
hold on
plot(x,larval);
hold on
plot(x,adult);
legend('plankton','salmon','larval','adult');
hold off
%}
summass=plankton+salmon+larval+adult;
plankton=plankton./summass;
salmon=salmon./summass;
larval=larval./summass;
adult=adult./summass;
Hst=-plankton.*log(plankton)-salmon.*log(salmon)-larval.*log(larval)-adult.*log(adult);

%% 动态模型
st=dy;
plankton=st(:,1);
plankton=plankton*250000*0.000001;%设定浮游生物平均质量为1mg
salmon=st(:,2);
salmon=3.6*salmon;
larval=st(:,3);
larval=larval*0.01;
adult=st(:,4);
adult=adult*0.311;
x=1:120;
%{
plot(x,plankton);
hold on
plot(x,salmon);
hold on
plot(x,larval);
hold on
plot(x,adult);
legend('plankton','salmon','larval','adult');
hold off
%}
summass=plankton+salmon+larval+adult;
plankton=plankton./summass;
salmon=salmon./summass;
larval=larval./summass;
adult=adult./summass;
Hdy=-plankton.*log(plankton)-salmon.*log(salmon)-larval.*log(larval)-adult.*log(adult);
%{
plot(x,plankton);
hold on
plot(x,salmon);
hold on
plot(x,larval);
hold on
plot(x,adult);
legend('plankton','salmon','larval','adult');
hold off
%}
stem(x,Hst,'color',[0.54,0.17,0.89]);
hold on
stem(x,Hdy,'color',[0.00,0.79,0.34]);
legend('stable','dynamic','Fontsize',15)
ylabel('H','FontSize',15);
xlabel('Time','FontSize',15)
title('The difference between sex ratio dynamic and stable models regarding Shannon-Wiener Index(H)','FontSize',15)
hold off