function c = lookback_opt_pricing( STs, min_Sts)
    % STs is is a row vector with every entry being a ST in one simulation.
    % r is the risk free interest rate per unit of T.
    % T is the number of trading days.
    global rf_r;
    global T;
    
    c_before_discount = mean(max(STs - min_Sts, 0));
    c = exp(-rf_r * T) * c_before_discount;

end

