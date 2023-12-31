%-------------------------------------------------------------------------%
%------------------ Optimization of 4-Stroke Engine Parameters ------------%
%-------------------------------------------------------------------------%
% This MATLAB code performs optimization on parameters related to a        %
% 4-stroke engine using three different optimization techniques:          %
% gradient-based optimization (fmincon), genetic algorithms (ga),         %
% and derivative-free optimization (fminsearch). The optimization aims    %
% to find optimal values for parameters that affect the engine's           %
% performance. The parameters include stroke length (s), retardation of   %
% closure of the intake valve (RCA), advancement of the exhaust valve      %
% opening (AAE), advance in the closure of the combustion inlet valve     %
% (AICB), and the compression ratio (RG).                                 %
%                                                                         %
% The optimization techniques are applied sequentially, and the results   %
% are displayed along with execution times.                               %
%                                                                         %
% Author: Jon Errasti Odriozola                                           %
% Date: May 2022                                                          %
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%

% Set initial parameters and options
initialParameters = [40, 30, 45, 37, 16];
lowerBounds = [20, 20, 35, 15, 8];
upperBounds = [100, 60, 50, 45, 20];

% Add the models directory to the MATLAB path
addpath('Engine_Model');

%%
%-------------------------------------------------------------------------%
% Gradient-based optimization using fmincon
%-------------------------------------------------------------------------%
optimizationType = "Gradient-based (fmincon)";
[xGradient, fvalGradient, exitflagGradient, outputGradient] = optimizeWithFmincon(initialParameters, lowerBounds, upperBounds);
displayOptimizationResults(optimizationType, xGradient, fvalGradient);

%%
%-------------------------------------------------------------------------%
% Genetic algorithms optimization
%-------------------------------------------------------------------------%
optimizationType = "Genetic Algorithms (ga)";
[xGA, fvalGA, exitflagGA, outputGA] = optimizeWithGA(initialParameters, lowerBounds, upperBounds);
displayOptimizationResults(optimizationType, xGA, fvalGA);

%%
%-------------------------------------------------------------------------%
% Derivative-free optimization using fminsearch
%-------------------------------------------------------------------------%
optimizationType = "Derivative-free (fminsearch)";
[xFminsearch, fvalFminsearch, exitflagFminsearch, outputFminsearch] = optimizeWithFminsearch(initialParameters);
displayOptimizationResults(optimizationType, xFminsearch, fvalFminsearch);

%%
%-------------------------------------------------------------------------%
% Functions
%-------------------------------------------------------------------------%
function [x, fval, exitflag, output] = optimizeWithFmincon(initialParameters, lowerBounds, upperBounds)
    options = optimoptions('fmincon', 'Display', 'off', 'Algorithm', 'sqp');
    [x, fval, exitflag, output] = fmincon(@F, initialParameters, [], [], [], [], lowerBounds, upperBounds, @constraints, options);
end

function [x, fval, exitflag, output] = optimizeWithGA(initialParameters, lowerBounds, upperBounds)
    options = optimoptions('ga', 'Display', 'iter', 'PlotFcns', @gaplotbestf, 'MaxGenerations', 50, 'PopulationSize', 100);
    [x, fval, exitflag, output] = ga(@F, length(initialParameters), [], [], [], [], lowerBounds, upperBounds, [], [], options);
end

function [x, fval, exitflag, output] = optimizeWithFminsearch(initialParameters)
    options = optimset('fminsearch');
    options.Display = 'iter';
    options.Algorithm = 'active-set';
    [x, fval, exitflag, output] = fminsearch(@F, initialParameters, options);
end

function displayOptimizationResults(optimizationType, x, fval)
    fprintf('%s optimization:\n', optimizationType);
    fprintf('Optimal parameters: %s\n', num2str(x));
    fprintf('Optimal function value: %f\n', fval);
    fprintf('\n');
end


