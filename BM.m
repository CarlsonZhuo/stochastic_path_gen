function St = BM(mu, sigma, N) 
% This function generate the data for one brownian motion.
% The reason not to generate multiple BM together is that, we don't want
% our program to hit the memory threshold, and also for an easy migration
% To other programming languages.

%   mu - drift
%   sigma - diffusion
%   N - divide 1 time unit into N units.
    global T;
    global initial_capital;
    S1 = initial_capital;
    dt = 1 / N;

    St = zeros(N*T, 1);
    St(1) = S1;
    for i=2:N*T
        z = randn; 
        S = St(i-1) + St(i-1) * (mu*dt + sigma*z*sqrt(dt));
        St(i) = S;
    end
    % hold on; plot(St);
    % xlim([1 N*T]);
    % xlabel('Trading Days')
    % ylabel('Simulated Portfolio Value ($)');
    