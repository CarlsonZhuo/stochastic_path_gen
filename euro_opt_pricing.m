function [c, MSE_inexact] = euro_opt_pricing( STs, strike_price, c_black_sholes)
    % STs is is a row vector with every entry being a ST in one simulation.
    % K is the strike price
    % r is the risk free interest rate per unit of T.
    % T is the number of trading days.
    
    global rf_r;
    global T;

    c_vector = max(STs - strike_price, 0);
    c_before_discount = mean(c_vector);
    c = exp(-rf_r * T) * c_before_discount;

    c_black_sholes_vector = c_black_sholes * ones(1, length(c_vector));
    MSE_inexact = mse(c_vector, c_black_sholes_vector);
end

