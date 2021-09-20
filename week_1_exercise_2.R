#Globe tossing ex 


#step 1: 
#Define the grid. This means you decide how many points to use in estimating the posterior, and then you make 
# a list of the parameter values on the grid 
p_grid <- seq(from = 0, to = 10, length.out=100)
plot(p_grid)
