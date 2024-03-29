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
%% Bieu dien Robot chuyen dong de kiem tra tinh chinh xac tu q1, q2, q3, q4 tim duoc
% Do thi mo phong 3D
 figure(4)
  P1=[0 0 0];
  viscircles([P1(3) P1(2)],0.005,'Color','r');
% Mo phong quy dao
curve=animatedline('Linewidth',1.5);
set(gca,'xlim',[-0.5 1.5],'Ylim',[-0.5 1.5],'Zlim',[-0.5 1.5]);
view(43,24);
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');

% Diem goc 0
for t_q1=0:0.05:1
    x0=0;
    y0=0;
    z0=0;
    plot3(x0,y0,z0,'b.',0,0,0,'r.')
    grid on
    hold on
end
% Diem A
for t_q1=0:0.05:1
    xA=0;
    yA=L0;
    zA=0;
    plot3(xA,yA,zA,'g.',0,L0,0,'r.')
    grid on
    hold on
end

% Diem O1
for t_q2=0:0.05:1
    x1=0;
    y1=q1*t_q2;
    z1=0;
    plot3(x1,y1,z1,'c.',0,q1,0,'r.')
    grid on
    hold on
end

% Diem O2
for t_q2=0:0.05:1
    x2=0;
    y2=q1*t_q2;
    z2=L1;
    plot3(x2,y2,z2,'y.',0,q1,L1,'r.')
    grid on
    hold on
end
% Diem O3
for t_q3=0:0.05:1
    x3=0;
    y3=-L2*sin(q2)*t_q3+q1;
    z3=L2*cos(q2)*t_q3+L1;
    
    x03=0;
    y03=-L2*sin(q2)+q1;
    z03=L2*cos(q2)+L1;
    
    plot3(x3,y3,z3,'b.',x03,y03,z03,'r.')
    grid on
    hold on
end
% Diem O4
for t_q4=0:0.1:1
    x4=0;
    y4=(-sin(q2)*L3*cos(q3) - cos(q2)*L3*sin(q3))*t_q4+y03; 
    z4=(cos(q2)*L3*cos(q3) - sin(q2)*L3*sin(q3) + L2*cos(q2))*t_q4 + z03;

    x04=0;
    y04=(-sin(q2)*L3*cos(q3) - cos(q2)*L3*sin(q3))+y03;
    z04=(cos(q2)*L3*cos(q3) - sin(q2)*L3*sin(q3) + L2*cos(q2)) + z03;
    plot3(x4,y4,z4,'k.',x04,y04,z04,'r.')
    grid on
    hold on
end
% Diem E
for t_q5=0:0.1:1  

    xE=0;
    yE=((-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*cos(q4) + (sin(q2)*sin(q3) - cos(q2)*cos(q3))*L4*sin(q4))*t_q5 + y04;
    zE=((cos(q2)*cos(q3) - sin(q2)*sin(q3))*L4*cos(q4) + (-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*sin(q4))*t_q5 + z04;
    
    x0E=0;
    y0E=((-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*cos(q4) + (sin(q2)*sin(q3) - cos(q2)*cos(q3))*L4*sin(q4))+ y04;
    z0E=((cos(q2)*cos(q3) - sin(q2)*sin(q3))*L4*cos(q4) + (-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*sin(q4))+ z04;
   
    
    plot3(xE,yE,zE,'b.',x0E,y0E,z0E,'r.')
    grid on
    hold on
end
M(:,:) = getframe;
pause(0.05) 
hold on
grid on
end
