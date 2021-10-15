library(rethinking)
setwd("~/R/Exercises")
dataf <- read.csv(file="data_autumn2020.csv", sep=";", stringsAsFactors=FALSE)

dataf[72,3] <- "OT"
precis(dataf)
OT <- dataf$tp[dataf$technique == "OT"] 
NT <- dataf$tp[dataf$technique == "NT"] 
#priors 

#standardize log of 
#dataf$truepos <- scale( log(dataf$tp) )
#index variable for experience
dataf$experience <- ifelse( dataf$category=="ME" , 2 , 1 )
dataf$experience

m.NT <- ulam(
  alist(
    OT ~ dnorm( mu , sigma) ,
    mu <- alpha ,
    alpha ~ dnorm( 1 ,10 ) ,
    sigma ~ dexp( 1 )
  ) , data=list(y=y) , chains=4 )

#prior predictive distribution after we tested a bunch of values. this is sensible 
N <- 100
a <- rnorm( N , 0 , 0.2 )
plot( NULL , xlim=c(-2,2) , ylim=c(0,10) )
for ( i in 1:N ) curve( exp( a[i] * x  ) , add=TRUE , col=grau() )

N <- 100
a <- rnorm( N , 0 , 0.5 )
b <- rnorm( N , 0 , 0.2 )
plot( NULL , xlim=c(-2,2) , ylim=c(0,100) )
for ( i in 1:N ) curve( exp( a[i] * x  ) , add=TRUE , col=grau() )


dataf$P <- scale( log(dataf$subject) )
dataf$contact_id <- ifelse( dataf$technique=="ME" , 2 , 1 )

dat <- list(
  T = dataf$tp ,
  P = dataf$P ,
  cid = dataf$contact_id )


# intercept only
m11.900 <- ulam(
  alist(
    T ~ dpois( lambda ),
    log(lambda) <- a,
    
    a ~ dnorm( 3 , 0.5 ),
  ), data=dat , chains=4 , log_lik=TRUE )


precis(m11.900)
