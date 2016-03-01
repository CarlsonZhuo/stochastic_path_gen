function STs = batch_BM_exact( mu, sigma, N )
% Generate N brownian motion. Return the STs 1*N.
    STs = zeros(1,N);
    for i=1:N
        St = BM_exact(mu, sigma);
        STs(i) = St;
    end

end

