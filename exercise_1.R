print( "All models are wrong, but some are useful." )
#1. w.w.w.
#2. w.w.w.L
#3. L.w.w.L.W.w.w
p_grid <- seq( from=0, to=1, length.out=100)
likelihood <- dbinom(5, size=7, prob=p_grid)
prior <- ifelse(p_grid < 0.5, 0, 1) #this is a uniform prior
posterior <- likelihood * prior 
posterior <- posterior / sum(posterior) # standardize 
plot(posterior ~ p_grid, type='l')

#ex 3 
