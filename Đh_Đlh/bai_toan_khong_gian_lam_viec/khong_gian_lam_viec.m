clc
clear
close all

% chieu dai cac khau
[L0,L1,L2,L3,L4]=parameter4DOF();

% toa do diem cuoi cac khau o thoi diem ban dau
% q1 = 0.5, q2 = 2pi/3, q3= -2pi/3, q4=pi/2;

%diem O0 
xO0=0; yO0=0; zO0=0;
% diem A
xA=0; yA=L0; zA=0;
% diem O1
xO1=0; yO1=0.5; zO1=0;
% diem O2
xO2=0; yO2=0.5; zO2=L1;
% diem O3 
xO3=0; yO3=0.5*L2 + 0.5; zO3=L2*sqrt(3)/2 + L1;
%diem O4
xO4=0; yO4= 0.5*L3 + 0.5*L2 + 0.5; zO4=(L2-L3)*sqrt(3)/2 + L1;
% diem E
xE=0; yE=sqrt(3)/2*L4 + 0.5*L3 + 0.5*L2 + 0.5; zE=((L2 - L3)*sqrt(3))/2 + L1+L4/2;

X=[xO0,xA,xO1,xO2,xO3,xO4,xE];
Y=[yO0,yA,yO1,yO2,yO3,yO4,yE];
Z=[zO0,zA,zO1,zO2,zO3,zO4,zE];

Tool = plot3(X,Y,Z,'ro-','Linewidth',3,'XDataSource','X','YDataSource','Y','ZDataSource','Z');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
view([1 1 1])
set(gca,'DataAspectRatio',[1 1 1]);
grid on
hold('on');

% Tao gia tri cac bien khop ngau nhien
for q1 = 0:0.2:1
    for q2 = -180*pi/180:0.6:180*pi/180
        for q3 = -120*pi/180:0.6:60*pi/180
            for q4 = -90*pi/180:0.6:90*pi/180                
% Ve quy dao cua 4 khau
% Diem goc 0
X0=0; Y0=0; Z0=0;
% Diem A
XA=0; YA=L0; ZA=0;
% Diem O1
X1=0; Y1=q1; Z1=0;
% Diem O2
X2=0; Y2=q1; Z2=L1;
% Diem O3
X3=0; Y3=-L2*sin(q2) + q1; Z3=L2*cos(q2) + L1;
% Diem O4
X4=0;
Y4=-sin(q2)*L3*cos(q3) - cos(q2)*L3*sin(q3) - L2*sin(q2) + q1; 
Z4=cos(q2)*L3*cos(q3) - sin(q2)*L3*sin(q3) + L2*cos(q2) + L1;
% Diem E
XE=0;
YE=(-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*cos(q4) + (sin(q2)*sin(q3) - cos(q2)*cos(q3))*L4*sin(q4) - sin(q2)*L3*cos(q3) - cos(q2)*L3*sin(q3) - L2*sin(q2) + q1;
ZE=(cos(q2)*cos(q3) - sin(q2)*sin(q3))*L4*cos(q4) + (-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*sin(q4) + cos(q2)*L3*cos(q3) - sin(q2)*L3*sin(q3) + L2*cos(q2) + L1;

X=[X0 XA X1 X2 X3 X4 XE];
Y=[Y0 YA Y1 Y2 Y3 Y4 YE];
Z=[Z0 ZA Z1 Z2 Z3 Z4 ZE];

% Toa do diem thao tac
xE=0;
yE=(-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*cos(q4) + (sin(q2)*sin(q3) - cos(q2)*cos(q3))*L4*sin(q4) - sin(q2)*L3*cos(q3) - cos(q2)*L3*sin(q3) - L2*sin(q2) + q1;
zE=(cos(q2)*cos(q3) - sin(q2)*sin(q3))*L4*cos(q4) + (-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*sin(q4) + cos(q2)*L3*cos(q3) - sin(q2)*L3*sin(q3) + L2*cos(q2) + L1;
% Hien thi so lieu
q=[q1;q2;q3;q4];
XX=[xE;yE;zE];
% Ve do thi diem thao tac
plot3 (xE,yE,zE, 'b.') % Diem thao tac mau xanh
refreshdata(Tool,'caller')
drawnow
                   
            end
        end
    end
end



