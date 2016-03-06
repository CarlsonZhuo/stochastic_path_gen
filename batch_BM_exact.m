function STs = batch_BM_exact( mu, sigma, nbSamplePath )
% Generate N brownian motion. Return the STs 1*N.
    STs = zeros(1,nbSamplePath);
    for i=1:nbSamplePath
        St = BM_exact(mu, sigma);
        STs(i) = St;
    end

end

