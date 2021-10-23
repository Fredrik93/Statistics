library(tidyverse)
library(rethinking)
url <- "https://raw.githubusercontent.com/torkar/BDA-PL/main/docs/utils.R"

destFile <- "~/R/Exercises/dataWeekSeven.R"


download.file(url, destFile)

source(("~/R/Exercises/dataWeekSeven.R"))
setup.data()

d <- load.FSE(cleanup=TRUE)
d <- by.project.language(d)
d <- d[,-c(2:5,7:8)]
d$project <- as.integer(d$project)
dim(d)

set.seed(061215)
m0 <- ulam(
  alist(
    n_bugs ~ dgampois(lambda, phi),
    log(lambda) <- a_l[language_id],
    a_l[language_id] ~ dnorm(a_bar, sigma),
    a_bar ~ dnorm(0,1),
    sigma ~ dexp(1),
    phi ~ dexp(1)
  ), data=d, cores=2, chains=4, cmdstan=TRUE, log_lik=TRUE, iter=5e3
)

m1 <- ulam(
  alist(
    n_bugs ~ dgampois(lambda, phi),
    log(lambda) <- a_p[project],
    a_p[project] ~ dnorm(a_bar, sigma),
    a_bar ~ dnorm(0,0.2),
    sigma ~ dexp(1),
    phi ~ dexp(1)
  ), data=d, cores=1, chains=4, cmdstan=TRUE, log_lik=TRUE, iter=5e3
)

m2 <- ulam(
  alist(
    n_bugs ~ dgampois(lambda, phi),
    log(lambda) <- a_l[language_id]+  a_p[project],
    a_p[project] ~ dnorm(0, sigma_p),
    sigma_p ~ dexp(1),
    a_l[language_id] ~ dnorm(0, sigma_l),
    sigma_l ~ dexp(1),
    phi ~ dexp(1)
  ), data=d, cores=4, chains=1, cmdstan=TRUE, log_lik=TRUE, iter=5e3
)

m3 <- ulam(
  alist(
    n_bugs ~ dgampois(lambda , phi),
    log(lambda) <- a_l[ language_id ] + a_p[project],
    a_p[project] ~ dnorm (0, sigma_p),
    sigma_p ~ dexp (1) ,
    a_l[ language_id ] ~ dnorm(a_bar , sigma_l), #5
    a_bar ~ dnorm (0, 0.5) ,
    sigma_l ~ dexp (1) ,
    phi ~ dexp (1)
  ), data = d, cores = 1, chains = 4, cmdstan = TRUE ,
  log_lik = TRUE , iter = 5e3
)

m4 <- ulam(
  alist(
    n_bugs ~ dgampois(lambda , phi),
    log(lambda) <- a_l[ language_id ] + a_p[project],
    a_p[project] ~ dnorm(a_bar_p , sigma_p), #6
    sigma_p ~ dexp (1) ,
    a_l[ language_id ] ~ dnorm(a_bar_l , sigma_l), #7
    a_bar_l ~ dnorm (0, 0.5) ,
    a_bar_p ~ dnorm (0, 0.2) ,
    sigma_l ~ dexp (1) ,
    phi ~ dexp (1)
  ), data = d, cores = 4, chains = 4, cmdstan = TRUE ,
  log_lik = TRUE , iter = 1e4
)