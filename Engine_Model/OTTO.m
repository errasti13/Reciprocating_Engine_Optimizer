function [W,Ttot,gasto_comb, Pdet] = OTTO(T_inf,P_inf,lambda,rpm,cc1,fequ,gamma,Tw,a,n,NO,dcb1,...
    s,rg,rca,aae,aicb,miter,nc)
rg = rg;
s = s/1000;
qr = cc1/10^6; %Cilindrada en m2
b = sqrt((4*qr)/(s*pi)); %Diametro del piston
r2 = s/2;
w = rpm*(2*pi/60); %Velocidad de giro en rad/s

Avalv_a=0.4*pi*b^2/4;  %Area del piston
Avalv_e=0.3*pi*b^2/4;
dcb=round(dcb1*b/s);

% ******************************************************
% *   QANG : ESCRITURA DE FICHEROS (SI=1,NO=resto)     *
% ******************************************************
QANG=1;
ORIG=0;

princotto

%Estimación de pérdidas por rozamiento sin bombeo

      FMEP=1*(0.97+0.8*(Up/17.2)+0.6*(Up/17.2)^2); %Presión media de fricción en bar
      IMEP=Trabajo/qr*10;  % PMI en bar
      ETAM=(IMEP-FMEP)/IMEP;
      BMEP=ETAM*IMEP;  %Presion efectiva media
      Pow=BMEP*nc*qr/10*rpm/120/1000; %Potencia al freno en kW 
      Rend_e=Rend*ETAM; %Rendimiento volumetrico
      BSFC=3600000000/Rend_e/Li;  %BSFC en g/kWh consumo especifico
      Par=BMEP*nc*qr/10/4/pi; %Par generado por el motor
      %Cálculo detonación
      
       Pdet=0;
 gamma=1.3;
 ide=180+round(rca);
 tret1=0.01806*(NO/100)^3.4017*APTV(ide+1,2)^-1.7*exp(3800/APTV(ide+1,3));
 
  for ide=180+round(rca)+1:360-round(aicb)
      p=APTV(ide+1,2);
      T=APTV(ide+1,3);
      tret2=0.01806*(NO/100)^3.4017*p^-1.7*exp(3800/T); 
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180; %Riesgo de detonacion
      tret1=tret2;
  end
    
  for ide=360-round(aicb)+1:360-round(aicb)+round(dcb)
      p=APTV(ide+1,2);
      T=T2*(p*100000/P2)^((gamma-1)/gamma);
      tret2=0.01806*(NO/100)^3.4017*p^-1.7*exp(3800/T);
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180;
      tret1=tret2;
  end

  Pdet=Pdet/wrpm;
  Rend_vol=Masa_adm/(1+fequ/14.7)/(P_inf/287/T_inf)/qr*1000000; %Rendimiento volumetrico

  gasto_aire=nc*Masa_adm/(1+fequ/14.7)*rpm/120; %Consumo de aire
  gasto_comb=fequ/14.7*gasto_aire*3600; %Consumo de combustible
  
  W = Par*w; %Potencia del ciclo
  
%% Calculo de cinematica
% Variables para cinemática
s1=80;
vd=400;
lambda=0.25;

s=s1/1000;
b=(4*vd/s/100/pi)^(1/2)/100;
r2=s/2;
r3=r2/lambda;
e=0.01;
%Masas y biela
m1=0.4;
m3=0.55;
I3=0.0012;
delta=0.25;

Ttot = cindin(m1,m3,I3,delta,r2,r3,e,APTV,b,s,rpm,lambda);
end
