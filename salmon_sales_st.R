library(rstan)
data_list <- list(nA= 16, nB=16, sA=6, sB = 10)

stan_samples <- stan(file="salmon_sales_stan.stan", data = data_list)


plot(stan_samples)

posterior <- as.data.frame(stan_samples)
sum(posterior$rate_diff > 0) / length(posterior)