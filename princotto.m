if QANG==1
    datasal=fopen('data.sal','w');
    APTVsal=fopen('aptv.sal','w');
end

QPTR=0;
QDISP=0;
Q1=1;
APTV=zeros(721,6);
cw=1;
cw=1;

%% Operaciones 

pres=P_inf;
vpmi=rg*qr/(rg-1);
vpms=vpmi/rg;
wrpm=rpm*pi/30;   
v1=V(r2,b,lambda,vpms,180+rca);
vaae=V(r2,b,lambda,vpms,540-aae);
rc=v1/vpms;
dt=1/6/rpm; %Dtheta es 1 grado

if (fequ>1.03)
    feq=1.03;
else
    feq=fequ;
end

RU=8.314472; % RU en J/mol/K
RT=0.08205746; % RT en atm*l/mol/k
Freal=fequ/14.7;
MM=(1+Freal)/(1/28.9+Freal/114)/1000;  
RG=RU/MM;
Li=4.419E07; %en J/kg

maxiter=20000;
eps=1e-6;    
eps2=1e-6;

%Velocidad Media del émbolo
Up=rpm*s/30; %Velocidad del piston

%Valor incicial de la temperatura al final de escape
Te=1000;
%    ***** COMIENZO DE LAS ITERACIONES      *****
 
ITERA=0;
CLAVE=0;
if miter==1
  CLAVE=1;
end

for it=1:maxiter
   ITERA=ITERA+1;

  
    hgm=0;
    Tgm=0;
  
%     ***** PROCESO DE ADMISION. PUNTO 1'    *****
 
    admis;



% **********************************************************************      
%   HGM Y TGM EN EL PROCESO DE ADMISIàN
    
    V2=0;
    P2=0;
    C1=6.18;
    C2=0;
    Vol=vpmi;
    [qw,hg]=calor(P1P,T1P,b,Up,C1,C2,gamma,Vol,P1P,V1P,T1P,P2,V2,Tw,cw);
    hgm=hgm+hg*(180+rca);
    Tgm=Tgm+hg*T1P*(180+rca);
    
    compres  

    comb     

escape    

Trabajo=(Trabajo_adm+Trabajo_comp+Trabajo_comb+Trabajo_exp+Trabajo_esc);
Calor=Q_comp+Q_comb+Q_exp;
Hesc=-round(Hout*10)/10;
Hadm=round(Hin*10)/10;
QTx=round(QTotal*(1-exp(-a))*10)/10;
Rend=Trabajo/QTotal*feq/fequ;



    if it==miter-1
        Te=T5;
        pres=P5;
        CLAVE=1;
    else
        if (abs(Te-T5)>20)&&(CLAVE==0)
            Te=T5;
            pres=P5;
        elseif CLAVE==0
            Te=T5;
            pres=P5;
            CLAVE=1;
        else
            break;
        end
    end
end

