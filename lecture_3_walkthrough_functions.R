library(rethinking)
data(Howell1)
d <- Howell1
d2 <- d[ d$age >= 18 , ]

## R code 4.27
flist <- alist(
  height ~ dnorm( mu , sigma ) ,
  mu ~ dnorm( 178 , 20 ) ,
  sigma ~ dunif( 0 , 50 )
)

precis( m4.1 )

m4.1 <- quap( flist , data=d2 )

#extract samples: estimates of each parameter we have 
d_samples <- extract.samples(m4.1)
#print: str(d_samples)

#only sample from priors
d_prior<- extract.prior(m4.1)
#only sampled from the priors
#the values: even though we only look at the five datapoints it differs alot from the posterior (the code above i think, d_samples)
#print: str(d_prior)
#if youre itnerested in prior predictive checks then use this function! 
#will give a dataframe with only prior values 

#link: 
#for any function, if you have loaded the library, you have access to help files. 
#put a ? first then funciton e.g., ?sim 
# link vs sim? we use the posterior sample: 
#they are convenience function 
#if we take sim and we take the model we just sampled :
d_sim <- sim(m4.1)
str(d_sim)

d_link <- link(m4.1)
str(d_link)
#main difference: link computes the value of each linear model for each sample for each case in the model 
# takes the linear model and it computes the output of the linear model 
# sim() takes sigma as well, so we include uncertainty. sim is what we should use as default, were interesed in uncertainty for the complete outcome 
#link is really good if you want to udnerstand uncertainty concerinng specific parameters. How much uncertainty do we have around e.g., mu?

#use extract.sampels to get posterior 
#use extract pirors to only extract values from priors (disregard data)
#use link to get estimates concerning parameters and unertainty around these paratmeters
#use sim and take uncertainty and likelihood into account 
