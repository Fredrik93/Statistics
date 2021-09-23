library(rethinking)
data("Howell1")
d <- Howell1

d2 <- d[d$age >= 18,]
dens(d2$height)

#curve( dnorm(x, 178, 20), from = 100, to=250)