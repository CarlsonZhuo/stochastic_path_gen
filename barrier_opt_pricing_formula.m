function price = barrier_opt_pricing_formula(sigma, K, H)
    % STs final stock price
    % K is the strike price
    % H the barrier
    % q dividend rate
 
    global rf_r;
    global T; 
    global initial_capital;
    S0 = initial_capital;
    q = 0;
   
    m1 = (log(S0 / K) + (rf_r - q + sigma^2 / 2) * T) / (sigma * sqrt(T));
    m2 = (log(S0 / K) + (rf_r - q - sigma^2 / 2) * T) / (sigma * sqrt(T));
    
    lambad = (rf_r - q + sigma^2) / sigma^2;
    m3 = log(H^2 /(S0 * K))/(sigma * sqrt(T)) + lambad * sigma * sqrt(T);
    
    c = S0 * exp(-q * T) * normcdf(m1) - K * exp(-rf_r * T) * normcdf(m2);
    
    m4 = (log(S0/H))/(sigma * sqrt(T)) + lambad * sigma * sqrt(T);
    m5 = (log(H/S0))/(sigma * sqrt(T)) + lambad * sigma * sqrt(T);
    
  
        if H <= K
            cd = S0 * exp(-q * T) * (H / S0)^(2 * lambad) * normcdf(m3) - K * exp(-rf_r * T)*(H / S0)^(2 * lambad - 2) * normcdf(m3 - sigma * sqrt(T));
            STs = c - cd;
        end
        if H > K
            STs = S0 * normcdf(m4) * exp(-q * T) - K * exp(-rf_r * T) * normcdf(m4 - sigma * sqrt(T))...
                - S0 * exp(-q * T) * (H / S0)^(2 * lambad) * normcdf(m5) + K * exp(-rf_r * T)*(H / S0)^(2 * lambad - 2) * normcdf(m5 - sigma * sqrt(T)); 
        end
            price = STs;
end


