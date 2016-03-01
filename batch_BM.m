function [ STs, min_St ] = batch_BM( mu, sigma, granuilty, N )
% Generate N brownian motion. Return the min and ST, both 1*N.
    STs = zeros(1,N);
    min_St = zeros(1,N);
    for i=1:N
        Sts = BM(mu, sigma, granuilty);
        min_St(i) = min(Sts);
        STs(i) = Sts(end);
    end

end

