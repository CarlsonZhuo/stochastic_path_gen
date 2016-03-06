function price = euro_opt_pricing(STs, strike_price)
    % STs is is a row vector with every entry being a ST in one simulation.
    % K is the strike price
    % r is the risk free interest rate per unit of T.
    % T is the number of trading days.
    
    global rf_r;
    global T;

    c_vector = max(STs - strike_price, 0);
    price_before_discount = mean(c_vector);
    price = exp(-rf_r * T) * price_before_discount;

end

