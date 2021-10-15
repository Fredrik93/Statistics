library(rethinking)
setwd("~/R/Exercises")
d <- read.csv(file="data_autumn2020.csv", sep=";")


d[72,3] <- "OT"
d$technique <- ifelse( d$technique=="OT" , 2 , 1 )
d$category <- ifelse( d$category=="ME" , 2 , 1 )



#prior predictive check for the tp's. 
#this checks the mean .. and 8.3 seems kinda reasonable for tp's 
a <- rnorm(1e4,2,0.5)
lambda <- exp(a)
mean( lambda )
curve( dlnorm(x,2 , 0.5 ) , from=0 , to=100 , n=200 )

data_list <- list( Tp = d$tp, Technique = d$technique, Category = d$category )


m0 <- ulam(
  alist(
    Tp ~ dgampois(lambda,phi),
    log(lambda) <- alpha[Technique] * beta[Category],
    alpha[Technique] ~ dnorm(0,10),
    beta[Category] ~ dnorm(0, 10),
    phi ~ dexp(1)
  ), data = data_list, cores = 4, chains = 4, cmdstan = TRUE,
  iter = 5e3, log_lik = TRUE)


m1 <- ulam(
  alist(
    Tp ~ dgampois(lambda,phi),
    log(lambda) <- alpha[Technique] * beta[Category],
    alpha[Technique] ~ dnorm(0,0.5),
    beta[Category] ~ dnorm(0, 0.5),
    phi ~ dexp(1)
  ), data = data_list, cores = 4, chains = 4, cmdstan = TRUE,
  iter = 5e3, log_lik = TRUE)

m2 <- ulam(
  alist(
    Tp ~ dpois(lambda),
    lambda <- exp(alpha[Technique]),
    alpha[Technique] ~ dnorm(1,1)
  ),
  data= data_list, chains=4, log_lik=TRUE )


post0 <- extract.samples(m1)
#here we want to show the NTME, NTLE, OTME and OTLE
post0$dff <- post0$b[,1] - post0$b[,2]

precis_plot(precis(post0, 2), pars = c("dff"))

compare(m0,m1 ,func=PSIS)

