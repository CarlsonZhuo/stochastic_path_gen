% Fix repetition to 1000 and find the relation between granuilty and MSE
repetition = 10000;

MSE_exact_result = ones(1, 100);
MSE_inexact_result = ones(1, 100);
price_diff_result_exact = ones(1, 100);
price_diff_result_inexact = ones(1, 100);
for gran = 1:100 % in K
    gran
    [price_black_scholes, price_euro_opt_inexact, MSE_inexact, price_euro_opt_exact, MSE_exact, price_barrier_opt, price_lookback_opt] = main(gran, repetition);
    MSE_exact_result(gran) = MSE_exact;
    MSE_inexact_result(gran) = MSE_inexact;
    price_diff_result_exact(gran) = abs(price_black_scholes - price_euro_opt_exact);
    price_diff_result_inexact(gran) = abs(price_black_scholes - price_euro_opt_inexact);
end
clc;
figure;
plot(MSE_exact_result); hold on;
plot(MSE_inexact_result);
title('Relation between MSE and repetition');
xlabel('repetition (K)');
ylabel('MSE');