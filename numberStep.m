% Note: MSE = mean square error;
%       RAD = Relative Absolute Difference
tic

rept_for_MSE_mean = 1;
MSE_exact_buffer = ones(1, rept_for_MSE_mean);
MSE_inexact_buffer = ones(1, rept_for_MSE_mean);
RAD_exact_buffer = ones(1, rept_for_MSE_mean);
RAD_inexact_buffer = ones(1, rept_for_MSE_mean);

Barrier_opt_price_buffer = ones(1, rept_for_MSE_mean);
Look_back_opt_price_buffer = ones(1, rept_for_MSE_mean);

target_max_nbStepInAPath = 100;

MSE_exact = ones(1, target_max_nbStepInAPath);
MSE_inexact = ones(1, target_max_nbStepInAPath);
RAD_exact = ones(1, target_max_nbStepInAPath);
RAD_inexact = ones(1, target_max_nbStepInAPath);

Barrier_opt_price = ones(1, target_max_nbStepInAPath);
Look_back_opt_price = ones(1, target_max_nbStepInAPath);

for nbStepInAPath = 1:target_max_nbStepInAPath
    nbStepInAPath
    for i = 1:rept_for_MSE_mean
        [price_black_scholes, price_euro_opt_inexact, price_euro_opt_exact, price_barrier_opt, price_lookback_opt] = simulation(5000, nbStepInAPath);
        MSE_exact_buffer(i) = (price_black_scholes - price_euro_opt_exact)^2;
        MSE_inexact_buffer(i) = (price_black_scholes - price_euro_opt_inexact)^2;
        RAD_exact_buffer(i) = abs(price_black_scholes - price_euro_opt_exact) / price_black_scholes;
        RAD_inexact_buffer(i) = abs(price_black_scholes - price_euro_opt_inexact) / price_black_scholes;
                
        Barrier_opt_price_buffer(i) = price_barrier_opt;
        Look_back_opt_price_buffer(i) = price_lookback_opt;
    end
    MSE_exact(nbStepInAPath) = mean(MSE_exact_buffer);
    MSE_inexact(nbStepInAPath) = mean(MSE_inexact_buffer);
    RAD_exact(nbStepInAPath) = mean(RAD_exact_buffer);
    RAD_inexact(nbStepInAPath) = mean(RAD_inexact_buffer);
        
    Barrier_opt_price(nbStepInAPath) = mean(Barrier_opt_price_buffer);
    Look_back_opt_price(nbStepInAPath) = mean(Look_back_opt_price_buffer);
end


figure;
plot(MSE_exact, 'r'); hold on;
plot(MSE_inexact, 'b');
title('Relation Between MSE and nbStepInAPath');
xlabel('nbStepInAPath');
ylabel('MSE');
legend('MSE exact', 'MSE inexact')

figure;
plot(RAD_exact, 'r'); hold on;
plot(RAD_inexact, 'b');
title('Relation Between RAD and nbStepInAPath');
xlabel('nbStepInAPath');
ylabel('Relative Abs Diff');
legend('MSE exact', 'MSE inexact')


toc