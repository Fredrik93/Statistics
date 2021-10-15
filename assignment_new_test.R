library(rethinking)
# where is the file?
url <- "https://torkar.github.io/desharnais.csv"
# where should we place the file?
destFile <- "~/Downloads/desharnais.csv"
# d/l file
download.file(url, destFile)
# read the file into d
d <- read.csv("~/Downloads/desharnais.csv")
# remove columns we don’t need
d <- d[-c(1)]
str(d)
# check format
precis(d)

m0 <- ulam(
  alist(
    Effort ~ dgampois(lambda, phi),
    log(lambda) <- a[Language],
    a[Language] ~ dnorm(0,0.5),
    phi ~ dexp(1)
    ), data = d, cores = 4, chains = 4, cmdstan = TRUE,
  iter = 5e3, log_lik = TRUE)

m1 <- ulam(
  alist(
    Effort ~ dgampois(lambda,phi),
    log(lambda) <- a_l[Language] + a_t[TeamExp],
    a_l[Language] ~ dnorm(0,0.5),
    a_t[TeamExp] ~ dnorm(0,0.5),
    phi ~ dexp(1)
    ), data = d, cores = 4, chains = 4, cmdstan = TRUE,
  iter = 5e3, log_lik = TRUE)

post0 <- extract.samples(m0)
post0$diff12 <- post0$a_l[,1] - post0$a_l[,2]
post0$diff13 <- post0$a_l[,1] - post0$a_l[,3]
post0$diff23 <- post0$a_l[,2] - post0$a_l[,3]

post1 <- extract.samples(m1)
post1$diff12 <- post1$a_l[,1] - post1$a_l[,2]
post1$diff13 <- post1$a_l[,1] - post1$a_l[,3]
post1$diff23 <- post1$a_l[,2] - post1$a_l[,3]


precis_plot(precis(post0),pars = c("diff12","diff13","diff23"))
precis_plot(precis(post1),pars = c("diff12","diff13","diff23"))

compare(m0,m1, func= LOO)