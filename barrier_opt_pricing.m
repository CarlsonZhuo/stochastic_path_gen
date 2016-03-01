function mean_payoff = barrier_opt_pricing( STs, min_St, strike_price, barrier)
    % STs is is a row vector with every entry being a ST in one simulation.
    % K is the strike price
    % r is the risk free interest rate per unit of T.
    % T is the number of trading days.
    % b the barrier
    global rf_r;
    global T;

    STs_copy = STs;
    cross_barrier_or_not = min_St - barrier;
    for i = 1:length(STs)
        if cross_barrier_or_not(i) < 0
            STs_copy(i) = 0;
        end
    end
    payoff = max(STs_copy - strike_price, 0);
   
    mean_payoff = exp(-rf_r * T) * mean(payoff);
end

