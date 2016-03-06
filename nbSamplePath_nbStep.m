% Note: MSE = mean square error;
%       RAD = Relative Absolute Difference
tic
rept_for_MSE_mean = 100;
MSE_exact_buffer = ones(1, rept_for_MSE_mean);
MSE_inexact_buffer = ones(1, rept_for_MSE_mean);
RAD_exact_buffer = ones(1, rept_for_MSE_mean);
RAD_inexact_buffer = ones(1, rept_for_MSE_mean);

Barrier_opt_price_buffer = ones(1, rept_for_MSE_mean);
Look_back_opt_price_buffer = ones(1, rept_for_MSE_mean);

target_max_nbStepInAPath = 30;	% in 10
target_max_nbSamplePath = 30;   % in K

MSE_exact = ones(target_max_nbSamplePath, target_max_nbStepInAPath);
MSE_inexact = ones(target_max_nbSamplePath, target_max_nbStepInAPath);
RAD_exact = ones(target_max_nbSamplePath, target_max_nbStepInAPath);
RAD_inexact = ones(target_max_nbSamplePath, target_max_nbStepInAPath);

Barrier_opt_price = ones(target_max_nbSamplePath, target_max_nbStepInAPath);
Look_back_opt_price = ones(target_max_nbSamplePath, target_max_nbStepInAPath);

for nbSamplePath = 1:target_max_nbSamplePath % in K
    nbSamplePath
    for nbStepInAPath = 1:target_max_nbStepInAPath
        for i = 1:rept_for_MSE_mean
            [price_black_scholes, price_euro_opt_inexact, price_euro_opt_exact, price_barrier_opt, price_lookback_opt] = simulation(nbSamplePath * 1000, nbStepInAPath * 10);
            MSE_exact_buffer(i) = (price_black_scholes - price_euro_opt_exact)^2;
            MSE_inexact_buffer(i) = (price_black_scholes - price_euro_opt_inexact)^2;
            RAD_exact_buffer(i) = abs(price_black_scholes - price_euro_opt_exact) / price_black_scholes;
            RAD_inexact_buffer(i) = abs(price_black_scholes - price_euro_opt_inexact) / price_black_scholes;

            Barrier_opt_price_buffer(i) = price_barrier_opt;
            Look_back_opt_price_buffer(i) = price_lookback_opt;
        end
        MSE_exact(nbSamplePath, nbStepInAPath) = mean(MSE_exact_buffer);
        MSE_inexact(nbSamplePath, nbStepInAPath) = mean(MSE_inexact_buffer);
        RAD_exact(nbSamplePath, nbStepInAPath) = mean(RAD_exact_buffer);
        RAD_inexact(nbSamplePath, nbStepInAPath) = mean(RAD_inexact_buffer);

        Barrier_opt_price(nbSamplePath, nbStepInAPath) = mean(Barrier_opt_price_buffer);
        Look_back_opt_price(nbSamplePath, nbStepInAPath) = mean(Look_back_opt_price_buffer);
    end

end

figure;
surf(MSE_exact)
title('Relation Between Exact MSE and (Number of Step In a Path, Number of Sample Path)');
xlabel('Number of Step In a Path (*10)');
ylabel('Number of Sample Path (*1000)');
colormap cool; 
colorbar;

figure;
surf(MSE_inexact)
title('Relation Between Inexact MSE and (Number of Step In a Path, Number of Sample Path)');
xlabel('Number of Step In a Path (*10)');
ylabel('Number of Sample Path (*1000)');
colormap cool; 
colorbar;

figure;
surf(RAD_exact)
title('Relation Between Exact RAD and (Number of Step In a Path, Number of Sample Path)');
xlabel('Number of Step In a Path (*10)');
ylabel('Number of Sample Path (*1000)');
colormap cool; 
colorbar;

figure;
surf(RAD_inexact)
title('Relation Between Inexact RAD and (Number of Step In a Path, Number of Sample Path)');
xlabel('Number of Step In a Path (*10)');
ylabel('Number of Sample Path (*1000)');
colormap cool; 
colorbar;


toc