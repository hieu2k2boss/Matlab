function [Xd,dXd]=Quydao(t)
[L0,L1,L2,L3,L4]=parameter4DOF();
Xd(1)=0 %m
Xd(2)=-0.2+0.2*sin(pi*t/10); %m
Xd(3)=0.4*cos(pi*t/10); %m

dXd(1)=0;
dXd(2)=(0.2*pi/10)*cos(pi*t/10);
dXd(3)=-0.4*pi/10*sin(pi*t/10);
end