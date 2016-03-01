function price_black_scholes = black_scholes( sigma, strike_price )
%BLACK_SHALOES Summary of this function goes here
%   Detailed explanation goes here

    global initial_capital;
    global T;
    global rf_r;

    K = strike_price;
    S0 = initial_capital;
    
    d1 = log(S0 / K) + (rf_r + sigma^2 / 2) * T; % Nominator
    d1 = d1 / (sigma * sqrt(T));
    
    d2 = d1 - (sigma * sqrt(T));
    
    price_black_scholes = S0 * normcdf(d1) - K * exp(- rf_r * T) * normcdf(d2);

end

