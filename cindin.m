function Ttot = cindin(m1,m3,I3,delta,r2,r3,e,APTV,b,s,rpm,lambda)
theta2=APTV(:,1);
pres=APTV(:,2);

F1=-pi*b^2/4*(pres-1)*100000;

%Cinemática
wrpm=rpm*pi/30;
rb=0.25*r3;
theta2=(0:720)';
theta2rad=theta2*pi/180;

theta3=asin(e-lambda*sin(theta2rad));
r1=r3*(lambda*cos(theta2rad)+cos(theta3));

w3=-wrpm*lambda*cos(theta2rad)./cos(theta3);
v1=-r3*(lambda*wrpm*sin(theta2rad)+w3.*sin(theta3));

a3=lambda*wrpm^2*sin(theta2rad)./cos(theta3)-w3.^2.*sin(theta3)./cos(theta3);
a1=-r2*wrpm^2*cos(theta2rad)-r3*(a3.*sin(theta3)+w3.^2.*cos(theta3));


%Cálculo de par instantáneo
v3gx=-r2*wrpm*sin(theta2rad)-rb*w3.*sin(theta3);
v3gy=r2*wrpm*cos(theta2rad)+rb*w3.*cos(theta3);
a3gx=-r2*wrpm^2*cos(theta2rad)-rb*(a3.*sin(theta3)+w3.^2.*cos(theta3));
a3gy=-r2*wrpm^2*sin(theta2rad)+rb*(a3.*cos(theta3)-w3.^2.*sin(theta3));

T2=(-F1.*v1+I3*a3.*w3+m3*a3gx.*v3gx+m3*a3gy.*v3gy+m1*a1.*v1)/wrpm;
Tm=-T2;

%Cálculo de fuerzas
Rax=m1*a1-F1;
Rbx=-Rax-m3*a3gx;
Rby=(-T2+r2*Rbx.*sin(theta2rad))./cos(theta2rad)/r2;
Ray=-Rby-m3*a3gy;
Fr=-Ray;

%Par total
Ttot(1:120)=Tm(1:120)+Tm(121:240)+Tm(241:360)+Tm(361:480)+Tm(481:600)+Tm(601:720);
