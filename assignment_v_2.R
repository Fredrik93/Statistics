library(rethinking)
setwd("~/R/Exercises")
d <- read.csv(file="data_autumn2020.csv", sep=";")
View(d)
mean(d$tp)
var(d$tp)
d[72,3] <- "OT"

data_list <- list(
  Tp = d$tp,
  Technique = ifelse( d$technique=="NT" , 2 , 1 ),
  Category = ifelse( d$category=="ME" , 2 , 1 ) 
)


m.null <- ulam(
  alist(
    Tp ~ dgampois(lambda, phi),
    log(lambda) <- alpha,
    alpha ~ dnorm(0,10),
    phi ~ dexp(1)
  ), data = data_list, cores=4, chains = 4, cmdstan = TRUE, log_lik=TRUE
)

m0 <- ulam(
  alist(
    Tp ~ dgampois(lambda, phi),
    log(lambda) <- lala[Technique],
    lala[Technique] ~dnorm(0,0.5),
    phi ~ dexp(1)
  ), data = data_list, cores=4, chains = 4, cmdstan = TRUE, log_lik=TRUE
)


m1 <- ulam(
  alist(
    Tp ~ dgampois(lambda, phi),
    log(lambda) <- b[Category],
    b[Category] ~ dnorm(0,0.5),
    phi ~ dexp(1)
  ), data = data_list, cores = 4, chains = 4, cmdstan = TRUE,
  iter = 5e3, log_lik=TRUE
)

m2 <- ulam(
  alist(
    Tp ~ dgampois(lambda, phi),
    log(lambda) <- a[Technique] + b[Category],
    b[Category] ~ dnorm(0,0.5),
    a[Technique] ~dnorm(0,0.5),
    phi ~ dexp(1)
  ), data = data_list, cores = 2, chains = 4, cmdstan = TRUE,
  iter = 5e3, log_lik=TRUE
)

compare(m.null,m0,m1, m2, func=LOO)

#diff between techniques
OT <- sim(m2, data=list(Technique=1, Category=1,2))
NT <- sim(m2, data=list(Technique=2, Category=1,2))
diffTechniques <- OT-NT
table(sign(diffTechniques))

#diff between techniques less experienced subjects
OTLE <- sim(m2, data=list(Technique=1, Category=1))
NTLE <- sim(m2, data=list(Technique=2, Category=1))

#diff between techniques more experienced subjects
OTME <- sim(m2, data=list(Technique=1, Category=2))
NTME <- sim(m2, data=list(Technique=2, Category=2))

diffTechniquesME <-OTME - NTME
table(sign(diffTechniquesME))

diffTechniquesLE <- OTLE-NTLE
table(sign(diffTechniquesLE))


#prior predictive checks page 83 
sample_lambda <- rnorm( 1e4 , 0 , 50 )
sample_phi <- rexp(1e4,1)
prior_h <- rgampois(1e4,sample_lambda,sample_phi)
dens( prior_h )
precis(prior_h)

sample_lambda <- rnorm( 1e4 , 0 , 25 )
sample_phi <- rexp(1e4,1)
prior_h <- rgampois(1e4,sample_lambda,sample_phi)
dens( prior_h )
precis(prior_h)


sample_lambda <- rnorm( 1e4 , 0 , 0.5 )
sample_phi <- rexp(1e4,1)
prior_h <- rgampois(1e4,sample_lambda,sample_phi)
dens( prior_h )
precis(prior_h)

#posterior predictive check s107
postPredCheck <- link(m0,data=data_list, n=1e5)
mean(postPredCheck)
PI(postPredCheck, prob=0.89)
dens(postPredCheck)


trankplot(m0)
