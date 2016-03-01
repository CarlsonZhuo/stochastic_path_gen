
function ST = BM_exact(mu, sigma)
    global initial_capital;
    S1 = initial_capital;
    global T;
    
    z = randn; 
    temp = (mu - sigma^2 / 2) * T + sigma * sqrt(T) * z; 
    ST = S1* exp(temp);

