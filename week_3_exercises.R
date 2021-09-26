

p <- list()

p$island1 <- c(0.2,0.2,0.2,0.2,0.2)
p$island2 <- c(0.8,0.1,0.05,0.025,0.025)
p$island4 <- c(0.05,0.15,0.7,0.05,0.05)


p_norm <- lapply( p , function(q) q/sum(q))

( H <- sapply( p_norm , function(q) -sum(ifelse(q==0,0,q*log(q))) ) )


#island 1 has the highest entropy. Most likely this means that it can be realized the most 
#amount of ways too. pp.301 book


