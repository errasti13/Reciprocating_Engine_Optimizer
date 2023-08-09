function F = F(x)
    % Objective function for optimizing engine parameters
    
    % Global Parameter Declarations
    T_inf = 288.15;    % Ambient temperature in Kelvin
    P_inf = 101325;    % Ambient pressure in Pa
    lambda = 0.25;     % Connecting rod length to crank radius ratio
    rpm = 8000;        % Engine revolution speed in RPM
    cc = 1600;         % Engine displacement in cubic centimeters
    nc = 6;            % Number of cylinders
    cc1 = cc / nc;     % Individual cylinder displacement in cubic centimeters
    fequ = 1.03;       % Equivalent fuel-air ratio
    gamma = 1.3;       % Specific heat ratio of air
    Tw = 475;          % Engine block temperature in Kelvin
    a = 5;             % Wiebe model coefficient
    n = 3;             % Wiebe model coefficient
    NO = 119;          % Octane rating of gasoline
    dcb1 = 50;         % Ignition delay model parameter
    miter = 3;         % Number of iterations in calculations

    fclose('all');

    % Calling the OTTO function to calculate engine parameters
    [W, Ttot, gasto_comb, Pdet] = OTTO(T_inf, P_inf, lambda, rpm, cc1, fequ, gamma, Tw, a, n, NO, dcb1, ...
        x(1), x(5), x(2), x(3), x(4), miter, nc);

    if W < 10^3
        F = 10^6; % Set a high value for optimization to avoid low power
    elseif Pdet > 0.9
        F = 10^6; % Set a high value for optimization to avoid high pressure
    else
        F = 0.8 * 750000 / W + 0.2 * gasto_comb / 75;
    end
    
    % Displaying calculated engine parameters
    disp(sprintf('Power: %f', W))
    disp(sprintf('Fuel consumption per 100 km: %f L/100Km', gasto_comb / 3))
end

