n_draws <- 10000


prior <- runif(n_draws, min = 0, max = 1)

grid <- seq(from=0, to=1, length.out=1e4 )

#hist(prior)

generative_model <- function(rate){
  sim_data <- rbinom(1,size=16, prob=rate)
  sim_data
  }

#likelihood <- dbinom(6, size=16, prob=p_grid)

sim_data <- rep(NA,n_draws)
for (i in 1:n_draws) {
  sim_data[i] <- generative_model(prior[i])
}

posterior <- prior[sim_data == 6]

length(posterior)
# hist(posterior)
# precis(posterior)
# 
# median(posterior)
# quantile(posterior, c(0.05,0.95))
hist(posterior, xlim = c(0,1) )

mean(posterior)
quantile(posterior, c(0.025, 0.975))

sum(posterior > 0.2) / length(posterior)

# This can be done with a for loop
singnups <- rep(NA, length(post_rate))
for(i in 1:length(post_rate)) {
  singnups[i] <- rbinom(n = 1, size = 100, prob = post_rate[i])
}

# But since rbinom is vectorized we can simply write it like this:
signups <- rbinom(n = length(post_rate), size = 100, prob = post_rate)

hist(signups, xlim = c(0, 100))
