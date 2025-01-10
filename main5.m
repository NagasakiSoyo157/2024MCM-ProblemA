% 本程序之目的为讨论恒定模型下的动力系统平衡点和稳定性随r的变化
%% 初始化
clear
close all
clc
syms x [1 4];
syms a1 a2 c1 c2 b11 b12 b22 d11 d21 d22 p%定义系数
k=1000;

%% 计算平衡点
[solx1,solx2,solx3,solx4]=solve(a1*(x(1)+0.5)-b11*x(1)*x(3)-b12*x(1)*x(4)==0,a2*x(2)-b22*x(2)*x(4)==0,d11*x(1)*x(3)-c1*x(3)+p*x(4)==0,d21*x(1)*x(4)+d22*x(2)*x(4)-c2*x(4)==0,x(1),x(2),x(3),x(4));
balancepoint=[solx1,solx2,solx3,solx4];%平衡点

%% 计算雅可比矩阵
f=[a1*(x(1)+0.5)-b11*x(1)*x(3)-b12*x(1)*x(4),a2*x(2)-b22*x(2)*x(4),d11*x(1)*x(3)-c1*x(3)+p*x(4),d21*x(1)*x(4)+d22*x(2)*x(4)-c2*x(4)];
j=jacobian(f,x);%雅可比矩阵
e=eig(j);%特征值

%% 参数代入平衡点
point=balancepoint(3,:);%选择第i个平衡点
point=subs(point,a1,0.7);
point=subs(point,a2,0.5);
point=subs(point,c1,0.6);
point=subs(point,c2,0.3);
point=subs(point,b11,0.1);
point=subs(point,b22,0.1);
point=subs(point,b12,0);
point=subs(point,d11,0.08);
point=subs(point,d22,0.08);
point=subs(point,d21,0.08);

%% 平衡点代入雅可比矩阵特征值
e=balancepoint(1,:);
e=subs(e,a1,0.7);
e=subs(e,a2,0.5);
e=subs(e,c1,0.6);
e=subs(e,c2,0.3);
e=subs(e,b11,0.1);
e=subs(e,b22,0.1);
e=subs(e,b12,0);
e=subs(e,d11,0.08);
e=subs(e,d22,0.08);
e=subs(e,d21,0.08);
e=subs(e,x1,point(1));
e=subs(e,x2,point(2));
e=subs(e,x3,point(3));
e=subs(e,x4,point(4));

%% 变化p观察（第i个）平衡点类型
for i=0:0.001:2
    e=subs(e,p,i);
    e=double(e);
    if e<=0
        disp('稳定点')
        point=subs(point,p,i);
        point=double(point);
        disp(point);
        disp(i)
    elseif e>=0
        disp('不稳定点')
        point=subs(point,p,i);
        point=double(point);
        disp(point)
        disp(i)
    end
end