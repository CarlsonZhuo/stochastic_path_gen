function [ STs, min_St ] = batch_BM( mu, sigma, nbStepInAPath, nbSamplePath )
% Generate N brownian motion. Return the min and ST, both 1*N.
    STs = zeros(1,nbSamplePath);
    min_St = zeros(1,nbSamplePath);
    for i=1:nbSamplePath
        Sts = BM(mu, sigma, nbStepInAPath);
        min_St(i) = min(Sts);
        STs(i) = Sts(end);
    end

end

