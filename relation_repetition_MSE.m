% Fix granuilarity to 5 and find the relation between repetion and MSE
gran = 5;
MSE_exact_result = zeros(1, 100);
MSE_inexact_result = zeros(1, 100);
price_diff_result_exact = ones(1, 100);
price_diff_result_inexact = ones(1, 100);
for repetition = 1:100 % in K
    repetition
    [price_black_scholes, price_euro_opt_inexact, MSE_inexact, price_euro_opt_exact, MSE_exact, price_barrier_opt, price_lookback_opt] = main(gran, repetition * 1000);
    MSE_exact_result(repetition) = MSE_exact;
    MSE_inexact_result(repetition) = MSE_inexact;
    price_diff_result_exact(repetition) = abs(price_black_scholes - price_euro_opt_exact);
    price_diff_result_inexact(repetition) = abs(price_black_scholes - price_euro_opt_inexact);
end
clc;
figure;
plot(MSE_exact_result); hold on;
plot(MSE_inexact_result);
title('Relation between MSE and repetition');
xlabel('repetition (K)');
ylabel('MSE');
