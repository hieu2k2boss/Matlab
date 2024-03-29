clc
clear
%% Parameters
[L0,L1,L2,L3,L4]=parameter4DOF();
%% Vi tri ban dau cua diem thao tac E
xx_0=0;yy_0=-0.2;zz_0=0.4;
X_0=[yy_0;zz_0];% Vec to vi tri E
% Gia tri gan dung cua goc khop ban dau, su dung auto cad de xac dinh
q1_0=1.5182;q2_0=1.6339;q3_0=-0.5247;q4_0=0.758;
%% Tinh chinh xac gia tri goc khop ban dau q_0
for n=1:1:10^10
    Jnd_0=TinhJnd(q1_0,q2_0,q3_0,q4_0); % Tinh ma tran Jacobian theo q_0
    [xE_0,yE_0,zE_0]=Donghocthuan(q1_0,q2_0,q3_0,q4_0);% tinh lai xx_0, yy_0 theo q_0
    XX_0=[yE_0;zE_0];
    delta_q_0 = Jnd_0*(X_0 - XX_0);% Tinh gia tri hieu chinh delta_q_0
    % Tinh lai cac gia tri q_0 hieu chinh
    q1_0 = q1_0 + delta_q_0(1,1);
    q2_0 = q2_0 + delta_q_0(2,1);
    q3_0 = q3_0 + delta_q_0(3,1);
    q4_0 = q4_0 + delta_q_0(4,1);
    % khai bao do chinh xac can thiet va tao vong lap tinh toan
    ss=10^(-10);
    if abs(delta_q_0(1,1)) < ss 
        if abs(delta_q_0(2,1)) < ss
            if abs(delta_q_0(3,1)) < ss     
                if abs(delta_q_0(4,1)) < ss  
            break
                end
            end
        end
    end
    n;
end
% Xac nhan cac gia tri q_0 chinh xac sau khi hieu chinh
q1=q1_0
q2=q2_0
q3=q3_0
q4=q4_0
