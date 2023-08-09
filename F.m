function F = F(x)

%% Declaracion de parametros globales
T_inf = 288.15; %Temperatura ambiente en Kelvin
P_inf = 101325; %Presion ambiente en Pa
lambda = 0.25; %Relacion biela manivela
rpm = 8000;  %Velocidad de giro del motor
cc = 1600; %Cilindrada del motor en centimetros cubicos
nc = 6; %Numero de cilindros
cc1 = cc/nc; %Cilindrada unitaria en centimetros cubicos
fequ = 1.03; %Dosado equivalente
gamma = 1.3; %Gamma del aire
Tw = 475;  %Temperatura bloque motor
a = 5; %Coeficiente modelo Wiebe
n = 3; %Coeficiente modelo Wiebe
NO = 119; %Octanaje gasolina
dcb1 = 50;
%rg = 10; %Relacion de compresion
miter = 3; %Numero de iteraciones en el calculo

fclose('all');

[W,Ttot,gasto_comb, Pdet] = OTTO(T_inf,P_inf,lambda,rpm,cc1,fequ,gamma,Tw,a,n,NO,dcb1,x(1),x(5),x(2),...
    x(3),x(4),miter,nc);
if W < 10^3
    F = 10^6;
else if Pdet > 0.9
        F =10^6;
else
    F = 0.8*750000/W+0.2*gasto_comb/75;
    end
disp(sprintf('Potencia %f',W))
disp(sprintf("gasto por cada 100Km: %f L/100Km",gasto_comb/3)) % gasto por cada 100Km


end
