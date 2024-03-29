function Jnd=TinhJnd(q1,q2,q3,q4)
[L0,L1,L2,L3,L4]=parameter4DOF();
%% Jacobian
J=zeros(2,4);

J11=1;
J12=((-L4 * cos(q4) - L3) * cos(q3) + sin(q3) * sin(q4) * L4 - L2) * cos(q2) + sin(q2) * (sin(q4) * L4 * cos(q3) + sin(q3) * (L4 * cos(q4) + L3));
J13=((-L4 * cos(q4) - L3) * cos(q3) + sin(q3) * sin(q4) * L4) * cos(q2) + (sin(q4) * L4 * cos(q3) + sin(q3) * (L4 * cos(q4) + L3)) * sin(q2);
J14= (sin(q4) * (cos(q2) * sin(q3) + sin(q2) * cos(q3)) - (cos(q2) * cos(q3) - sin(q2) * sin(q3)) * cos(q4)) * L4;

J21=0;
J22=((-L4 * cos(q4) - L3) * cos(q3) + sin(q3) * sin(q4) * L4 - L2) * sin(q2) - cos(q2) * (sin(q4) * L4 * cos(q3) + sin(q3) * (L4 * cos(q4) + L3));
J23=(-sin(q4) * L4 * cos(q3) - sin(q3) * (L4 * cos(q4) + L3)) * cos(q2) - sin(q2) * ((L4 * cos(q4) + L3) * cos(q3) - sin(q3) * sin(q4) * L4);
J24=-((cos(q2) * sin(q3) + sin(q2) * cos(q3)) * cos(q4) + (cos(q2) * cos(q3) - sin(q2) * sin(q3)) * sin(q4)) * L4;
J=[J11 J12 J13 J14;J21 J22 J23 J24];

%% Chuyen vi Jacobian
Jt=J';
%% Jacobi tua nghich dao
Jnd = (Jt*inv(J*Jt));
end