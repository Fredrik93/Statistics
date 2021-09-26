library(rstan)

data_list <- list(n=30, x = 10)
s <- stan(file = 'test_stan.stan', data=data_list)

plot(s)
