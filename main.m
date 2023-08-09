%-----------------------------------------------------------% 
%-----------------------------------------------------------%
%---------- Codigo optimizacion motor 4 tiempos ------------%
%-----------------------------------------------------------%
%-----------------------------------------------------------%


% Las variables para este trabajo he supuesto que son los mismos
% que para el trabajo de MAA de grado: relacion carrera/diametro
% del embolo, retardo al cierre de admision (RCA), adelanto a la
% apertura del escape (AAE) y relacion de compresion. En clase se
% dijo que tiene que ser de 4-6 variables, podemos meter un quinto


%% Optimizacion tipo gradiente
clc
clear

x0 = [40,30,45,37,16]; %Valores iniciales s, rca, aae, aicb, rg
lb=[20 20, 35, 15,8];ub=[100 60 50 45 20]; % set Lower & Upper bounds
% Start with the default options
options = optimoptions('fmincon');
% Modify options setting
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'Algorithm', 'sqp');
%options = optimoptions(options,'DiffMinChange',10^0);
%options = optimoptions(options,'OutputFcn',@plot_iter1);
[x,fval,exitflag,output,lambda,grad,hessian] = ...
fmincon(@F,x0,[],[],[],[],lb,ub,@constraints,options);
disp(sprintf('F: Minimum is at x(1)=%f x(2)=%f x(3)=%f x(4)=%f x(5)=%f, Function value is %f',...
    x(1),x(2),x(3),x(4),x(5),fval));


%% Genetic algorithms
clear
clc
time = cputime;
nvars=7; lb=[40 44, 44, 44, 19];ub=[41 45 45 45 20]; % set Lower & Upper bounds
options = optimoptions('ga');
% Modify options setting
options = optimoptions(options,'Display', 'iter');
options = optimoptions(options,'PlotFcns',@gaplotbestf);
options = optimoptions(options, 'MaxGenerations', 50)
options = optimoptions(options, 'PopulationSize',100)
%options = optimoptions(options,'OutputFcn', { @plot_iter1 })
[x,fval,exitflag,output,population,score] = ...
    ga(@F,nvars,[],[],[],[],lb,ub,[],[],options);
disp(sprintf('F: Minimum is at x(1)=%f x(2)=%f x(3)=%f x(4)=%f x(5)=%f, Function value is %f',...
    x(1),x(2),x(3),x(4),x(5),fval));
time1 = cputime;
timer = time1-time

%%
clc
clear
x0 = [40,30,45,37,16]; %Valores iniciales s, rca, aae, aicb, rg
lb=[20 20, 35, 15,8];ub=[100 60 50 45 20]; % set Lower & Upper bounds
% Start with the default options
options = optimset('fminsearch');
% Modify options setting
options = optimset(options,'Display', 'iter');
options = optimset(options,'Algorithm', 'active-set');
%options = optimoptions(options,'DiffMinChange',10^0);
%options = optimoptions(options,'OutputFcn',@plot_iter1);
options = optimset('PlotFcns',@optimplotfval);
[x,fval,exitflag,output] = ...
fminsearch(@F,x0,options);
disp(sprintf('F: Minimum is at x(1)=%f x(2)=%f x(3)=%f x(4)=%f x(5)=%f, Function value is %f',...
    x(1),x(2),x(3),x(4),x(5),fval));

