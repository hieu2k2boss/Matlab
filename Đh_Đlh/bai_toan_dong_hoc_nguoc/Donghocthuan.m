function [xE,yE,zE]=Donghocthuan(q1,q2,q3,q4)
[L0,L1,L2,L3,L4]=parameter4DOF();
xE=0;
yE=(-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*cos(q4) + (sin(q2)*sin(q3) - cos(q2)*cos(q3))*L4*sin(q4) - sin(q2)*L3*cos(q3) - cos(q2)*L3*sin(q3) - L2*sin(q2) + q1;
zE=(cos(q2)*cos(q3) - sin(q2)*sin(q3))*L4*cos(q4) + (-sin(q2)*cos(q3) - cos(q2)*sin(q3))*L4*sin(q4) + cos(q2)*L3*cos(q3) - sin(q2)*L3*sin(q3) + L2*cos(q2) + L1;
end