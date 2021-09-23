#Globe tossing ex 


#step 1: 
#Define the grid. This means you decide how many points to use in estimating the posterior, and then you make 
# a list of the parameter values on the grid 
p_grid <- seq(from = 0, to = 1, length.out=20)

#Step 2: 
#Compute the value of the prior at each parameter value on the grid 
#this is a uniform prior, all 20 values are expected to be 1 (water)
#prior <- rep(1,20)

#this is another prior
#prior <- ifelse(p_grid < 0.5, 0, 1 )

#and another
prior<- exp( -5*abs(p_grid -0.5))

#Step 3: 
#Compute the likelihood at each parameter value
likelihood <- dbinom(6, size=9, prob=p_grid)

#Step 4:
#Compute the unstandardized posterior at each parameter value, by multiplying the prior to the likelihood
unstandardized.posterior <- likelihood * prior 

#Step 5: 
#Standardize the posterior by dividing each value by the sum of all values 
posterior <- unstandardized.posterior / sum(unstandardized.posterior)
plot(posterior)

#Display the posterior probability distribution: 
plot(p_grid, posterior, type='b',
     xlab="Probability of water", ylab="Posterior Probability"
     )
mtext("20 Points")
