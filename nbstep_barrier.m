% Note: MSE = mean square error;
%       RAD = Relative Absolute Difference
tic
rept_for_MSE_mean = 1;
MSE_buffer = ones(1, rept_for_MSE_mean);
RAD_buffer = ones(1, rept_for_MSE_mean);

target_max_nbStepInAPath = 100;

MSE = ones(1, target_max_nbStepInAPath);
RAD = ones(1, target_max_nbStepInAPath);

nbSamplePath = 10000;
for nbStepInAPath = 1:target_max_nbStepInAPath % in K
    nbStepInAPath 
    for i =1:rept_for_MSE_mean
        [price_black_scholes, price_euro_opt_inexact, price_euro_opt_exact, price_barrier_opt,price_barrier_opt_formula, price_lookback_opt] = simulation(nbSamplePath, nbStepInAPath);
              
        MSE_buffer(i) = (price_barrier_opt_formula - price_barrier_opt)^2;
        RAD_buffer(i) = abs(price_barrier_opt_formula - price_barrier_opt) / price_barrier_opt_formula;
        
    end
    MSE(nbStepInAPath) = mean(MSE_buffer);
    RAD(nbStepInAPath) = mean(RAD_buffer);
end

figure;
plot(MSE, 'r'); 
title('Relation Between MSE and nbSamplePath');
xlabel('nbStepInAPath');
ylabel('MSE');
legend('MSE')

figure;
plot(RAD, 'r');
title('Relation Between RAD and nbSamplePath');
xlabel('nbStepInAPath');
ylabel('Relative Abs Diff');
legend('RAD')

toc

