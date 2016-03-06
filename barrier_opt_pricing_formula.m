function mean_payoff = barrier_opt_pricing_formula(sigma, K, B)
    % STs is is a row vector with every entry being a ST in one simulation.
    % K is the strike price
    % r is the risk free interest rate per unit of T.
    % T is the number of trading days.
    % b the barrier
    global rf_r;
    global T; 
    global initial_capital;
    S0 = initial_capital;
    
    d1 = (log(S0 / K) + (rf_r + sigma^2 / 2) * T) / (sigma * sqrt(T));
    d2 = (log(S0 / K) + (rf_r - sigma^2 / 2) * T) / (sigma * sqrt(T));
    d3 = (log(S0 / B) + (rf_r - sigma^2 / 2) * T) / (sigma * sqrt(T));
    d4 = (log(S0 / B) + (rf_r - sigma^2 / 2) * T) / (sigma * sqrt(T));
    d5 = (log(S0 / B) - (rf_r - sigma^2 / 2) * T) / (sigma * sqrt(T));
    d6 = (log(S0 / B) - (rf_r + sigma^2 / 2) * T) / (sigma * sqrt(T));
    d7 = (log(S0 * K / B^2) - (rf_r - sigma^2 / 2) * T) / (sigma * sqrt(T));
    d8 = (log(S0 * K / B^2) - (rf_r + sigma^2 / 2) * T) / (sigma * sqrt(T));
    a = (B / S0)^(- 1 + 2 * rf_r/ sigma^2);
    b = (B / S0)^(1 + 2 * rf_r/ sigma^2);
    mean_payoff = K * exp(- rf_r * T) * (normcdf(d4) - normcdf(d2) - a * (normcdf(d7) - normcdf(d5)))...
                  - S0 * (normcdf(d3) - normcdf(d1) - b * (normcdf(d8) - normcdf(d6)));   

end

