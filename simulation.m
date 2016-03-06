function [price_black_scholes, price_euro_opt, price_euro_opt_exact, price_barrier_opt, price_lookback_opt] = simulation(nbSamplePath, nbStepInAPath)
    % Define some global vars
    global T;
    T = 100;
    global rf_r;       % the risk free interest rate
    rf_r = 0.0001;
    global initial_capital;
    initial_capital = 1000;


    sigma = 0.005;
    mu = rf_r;
    strike_price = 1000;
    % Compute the price by black-sholes formula
    price_black_scholes = black_scholes(sigma, strike_price);

    % Generate A Series of GBM, Sts
    [STs1, min_St] = batch_BM(mu, sigma, nbStepInAPath, nbSamplePath);

    % Pricing the European Option
    price_euro_opt = euro_opt_pricing(STs1, strike_price);

    % Compare the exact way and the in-exact way to price European Options.
    STs2 = batch_BM_exact(mu, sigma, nbSamplePath);
    price_euro_opt_exact = euro_opt_pricing(STs2, strike_price);

    % Pricing the Barrier Option
    barrier = 1000;
    price_barrier_opt = barrier_opt_pricing(STs1, min_St, strike_price, barrier);

    % Pricing the LookBack Option
    price_lookback_opt = lookback_opt_pricing(STs1, min_St);
