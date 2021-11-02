set.seed(2971)
N <- 100
# 100 lines
a <- rnorm( N , 178 , 20 )
b <- rnorm( N , 0 , 10 )

plot( NULL , xlim=range(d2$weight) , ylim=c(-100,400) ,
      xlab="weight" , ylab="height" )
abline( h=0 , lty=2 )
abline( h=272 , lty=1 , lwd=0.5 )
mtext( "b ~ dnorm(0,10)" )
xbar <- mean(d2$weight)


for ( i in 1:N ) curve( a[i] + b[i]*(x - xbar) ,
                        from=min(d2$weight) , to=max(d2$weight) , add=TRUE ,
                        col=col.alpha("black",0.2) )


b <- rlnorm( 1e4 , 0 , 1 )
dens( b , xlim=c(0,5) , adj=0.1 )


#try stuff again but with logarithmic values 
set.seed(2971)
N <- 100
# 100 lines
a <- rnorm( N , 178 , 20 )
b <- rlnorm( N , 0 , 1 )

plot( NULL , xlim=range(d2$weight) , ylim=c(-100,400) ,
      xlab="weight" , ylab="height" )
abline( h=0 , lty=2 )
abline( h=272 , lty=1 , lwd=0.5 )
mtext( "b ~ dnorm(0,10)" )
xbar <- mean(d2$weight)


for ( i in 1:N ) curve( a[i] + b[i]*(x - xbar) ,
                        from=min(d2$weight) , to=max(d2$weight) , add=TRUE ,
                        col=col.alpha("black",0.2) )
