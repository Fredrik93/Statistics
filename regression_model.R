library(rethinking)
data(Howell1)
d <- Howell1
d2 <- d[ d$age >= 18 , ]
 xbar <- mean(d2$weight)
m4.3 <- 
  quap(
    alist(
      height ~dnorm(mu,sigma),
      mu <- a + b*(weight-xbar),
      a ~dnorm(178,20),
      b ~dlnorm(0,1),
      sigma ~ dunif(0,50)
    ), data=d2
  )

precis(m4.3)
round( vcov( m4.3 ) , 3 )


plot( height ~ weight , data=d2 , col=rangi2 )

post <- extract.samples( m4.3 )
a_map <- mean(post$a)
b_map <- mean(post$b)
curve( a_map + b_map*(x - xbar) , add=TRUE )

globe.qa <- quap(
  alist( W ~ dbinom(W+L, p),
         p ~dunif(0,1)
         ), data=list(W=6,L=3))

precis(globe.qa)

# analytical calculation
W <- 6
L <- 3
curve( dbeta( x , W+1 , L+1 ) , from=0 , to=1 )
# quadratic approximation
curve( dnorm( x , 0.67 , 0.16 ) , lty=2 , add=TRUE )