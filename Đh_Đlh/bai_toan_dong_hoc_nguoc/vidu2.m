clc
clear
%% Parameters
[L0,L1,L2,L3,L4]=parameter4DOF();
%% Vi tri ban dau cua diem thao tac E
yy_0=-0.2;zz_0=0.4;
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
q1=q1_0;
q2=q2_0;
q3=q3_0;
q4=q4_0;
%% Thuat toan ap dung cho toan bo quy dao x, y, z cho truoc
% bien thoi gian
dt=0.1; % Khai bao buoc thoi gian chay
t_max=5; % Khai bao thoi gian
%%
for t=0:dt:t_max
[Xd,dXd]=Quydao(t); % Vi tri va van toc diem E cho truoc theo thoi gian t
Jnd=TinhJnd(q1,q2,q3,q4); % Tinh ma tran Jacobian theo q
dX=[dXd(2);dXd(3)]; % Vec to van toc diem thao tac E cho truoc
q=[q1;q2;q3;q4];
dq=Jnd*dX; % Van toc goc khop
for k=1:1:10^5
    q_k=q + dq*dt; % Tinh gia tri goc khop trong vong lap bien k
    q1=q_k(1,1);
    q2=q_k(2,1);
    q3=q_k(3,1);
    q4=q_k(4,1);
    Jnd_real=TinhJnd(q1,q2,q3,q4); % Tinh lai gia tri ma tran Jacobian
    [xE,yE,zE]=Donghocthuan(q1,q2,q3,q4); % Tinh lai quy dao diem E tu q tim duoc
    Xq=[yE;zE];
    [Xd,dXd]=Quydao(t);% Goi quy dao mong muon
    Xm=[Xd(2);Xd(3)];
    Delta_q = Jnd_real*(Xm - Xq);% Tinh sai lech goc khop
    % khai bao do chinh xac can thiet
    ss1=10^(-5);
    if abs(Delta_q(1,1)) < ss1 
        if abs(Delta_q(2,1)) < ss1
            if abs(Delta_q(3,1)) < ss1 
                if abs(Delta_q(4,1)) < ss1       
            break
                end
            end
        end
    end     
end
    k;
    % Tinh lai gia tri goc khop chinh xac
    q1 = q1 + Delta_q(1,1);
    q2 = q2 + Delta_q(2,1);
    q3 = q3 + Delta_q(3,1);
    q4 = q4 + Delta_q(4,1);
% Tinh lai quy dao lan nua
  [xE_tinhlai,yE_tinhlai,zE_tinhlai]=Donghocthuan(q1,q2,q3,q4);
  
%% 
% Thiet lap vecto sai so quy dao
eX=xE-xE_tinhlai;
eY=yE-yE_tinhlai;
eZ=zE-zE_tinhlai;
%% Ve do thi
% Do thi cac bien khop - ket qua bai toan dong hoc nguoc
figure(1)
    plot(t,q1,'r.',t,q2,'g.',t,q3,'b.',t,q4,'k.')
    xlabel('time (sec)')
    ylabel('Bien khop q1, q2 va q3')
    hold on
    grid on
 % Do thi quy dao thao tac
 figure(2)
    plot(t,xE_tinhlai,'r.',t,yE_tinhlai,'g.',t,zE_tinhlai,'b.')
    xlabel('time (sec)')
    ylabel('Do thi quy dao thao tac tinh lai')
    hold on
    grid on
 % Do thi sai so quy dao thao tac
 figure(3)
    plot(t,eX,'r.',t,eY,'g.',t,eZ,'b.')
    xlabel('time (sec)')
    ylabel('Do thi quy dao thao tac tinh lai')
    hold on
    grid on
end
