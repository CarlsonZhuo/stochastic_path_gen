% Note: MSE = mean square error;
%       RAD = Relative Absolute Difference
tic
product = 100; % times 100
rept_for_MSE_mean = 100;
MSE_exact_buffer = ones(1, rept_for_MSE_mean);
MSE_inexact_buffer = ones(1, rept_for_MSE_mean);
RAD_exact_buffer = ones(1, rept_for_MSE_mean);
RAD_inexact_buffer = ones(1, rept_for_MSE_mean);

Barrier_opt_price_buffer = ones(1, rept_for_MSE_mean);
Look_back_opt_price_buffer = ones(1, rept_for_MSE_mean);

target_max_nbSamplePath = 50;

MSE_exact = ones(1, target_max_nbSamplePath);
MSE_inexact = ones(1, target_max_nbSamplePath);
RAD_exact = ones(1, target_max_nbSamplePath);
RAD_inexact = ones(1, target_max_nbSamplePath);

Barrier_opt_price = ones(1, target_max_nbSamplePath);
Look_back_opt_price = ones(1, target_max_nbSamplePath);

nbStepInAPath = 50;
for nbSamplePath = 1:target_max_nbSamplePath % in K
    nbSamplePath
    for i = 1:rept_for_MSE_mean
        [price_black_scholes, price_euro_opt_inexact, price_euro_opt_exact, price_barrier_opt, price_lookback_opt] = simulation(nbSamplePath * 10, nbStepInAPath);
        MSE_exact_buffer(i) = (price_black_scholes - price_euro_opt_exact)^2;
        MSE_inexact_buffer(i) = (price_black_scholes - price_euro_opt_inexact)^2;
        RAD_exact_buffer(i) = abs(price_black_scholes - price_euro_opt_exact) / price_black_scholes;
        RAD_inexact_buffer(i) = abs(price_black_scholes - price_euro_opt_inexact) / price_black_scholes;
        
        Barrier_opt_price_buffer(i) = price_barrier_opt;
        Look_back_opt_price_buffer(i) = price_lookback_opt;
        
    end
    MSE_exact(nbSamplePath) = mean(MSE_exact_buffer);
    MSE_inexact(nbSamplePath) = mean(MSE_inexact_buffer);
    RAD_exact(nbSamplePath) = mean(RAD_exact_buffer);
    RAD_inexact(nbSamplePath) = mean(RAD_inexact_buffer);
        
    Barrier_opt_price(nbSamplePath) = mean(Barrier_opt_price_buffer);
    Look_back_opt_price(nbSamplePath) = mean(Look_back_opt_price_buffer);
end

figure;
x = 10:10:500;
plot(x, MSE_exact, 'r'); hold on;
plot(x, MSE_inexact, 'b');
title('Relation Between MSE and nbStepInAPath');
xlabel('nbSamplePath');
ylabel('MSE');
legend('MSE exact', 'MSE inexact')

figure;
plot(x, RAD_exact, 'r'); hold on;
plot(x, RAD_inexact, 'b');
title('Relation Between RAD and nbStepInAPath');
xlabel('nbSamplePath');
ylabel('Relative Abs Diff');
legend('MSE exact', 'MSE inexact')

toc