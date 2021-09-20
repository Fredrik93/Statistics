#p <- c(0.7, 0.3) 

#-sum(p*log(p))

#q <- c(0.2, 0.8)
#-sum(q*log(q))

# we can see that the uncertainty has increased from p to q 

#so now we go through Kullback leibler example, now that we know that uncertainty decreased 

q <- c(0.7, 0.3)  # our model 
p <- c(0.01, 0.99) #True ratio on mars 
sum(p * log(p/q))

#how do we know if our surprise is high or low? 
# - its a relative measurement, we know that theres a difference (in this example it is 1.13 & 2.16)