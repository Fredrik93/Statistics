#ex1

p_grid <- seq(from = 0, to = 1, length.out=100)

#prior <- rep(1,100)
prior <- ifelse(p_grid < 0.5, 0, 1 )
likelihood <- dbinom(3, size=4, prob=p_grid)

unstd_posterior <- likelihood * prior

posterior <- unstd_posterior/ sum(unstd_posterior)

plot(posterior ~ p_grid, type='l')