% Note: MSE = mean square error;
%       RAD = Relative Absolute Difference
tic
rept_for_MSE_mean = 100;
MSE_buffer = ones(1, rept_for_MSE_mean);
RAD_buffer = ones(1, rept_for_MSE_mean);

target_max_nbSamplePath = 50;

MSE = ones(1, target_max_nbSamplePath);
RAD = ones(1, target_max_nbSamplePath);

nbStepInAPath = 50;
for nbSamplePath = 1:target_max_nbSamplePath % in K
    nbSamplePath 
    for i =1:rept_for_MSE_mean
        [price_black_scholes, price_euro_opt_inexact, price_euro_opt_exact, price_barrier_opt,price_barrier_opt_formula, price_lookback_opt] = simulation(nbSamplePath * 50, nbStepInAPath);
              
        MSE_buffer(i) = (price_barrier_opt_formula - price_barrier_opt)^2;
        RAD_buffer(i) = abs(price_barrier_opt_formula - price_barrier_opt) / price_barrier_opt_formula;
        
    end
    MSE(nbSamplePath) = mean(MSE_buffer);
    RAD(nbSamplePath) = mean(RAD_buffer);
end

figure;
plot(MSE, 'r'); 
title('Relation Between MSE and nbSamplePath');
xlabel('nbSamplePath');
ylabel('MSE');
legend('MSE')

figure;
plot(RAD, 'r');
title('Relation Between RAD and nbSamplePath');
xlabel('nbSamplePath');
ylabel('Relative Abs Diff');
legend('RAD')

toc

