//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int nA;
  int sA;
  int nB;
  int sB;
  
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0, upper=1> rateA;
  real<lower=0, upper=1> rateB;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  rateA ~ uniform(0,1);
  rateB ~ uniform(0,1);
  sA ~ binomial(nA, rateA);
  sB ~ binomial(nB, rateB);
}

generated quantities {
  real rate_diff;
  rate_diff = rateB - rateA;
}

