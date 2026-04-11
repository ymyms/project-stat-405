data {
  int<lower=0> N;
  vector<lower=0>[N] height;
  array[N] int<lower=0,upper=1> y;
}

parameters {
  real intercept;
  real slope;
}

model {
  intercept ~ normal(0, 10);
  slope  ~ normal(0, 10);
  y ~ bernoulli(inv_logit(intercept + slope * height));
}

generated quantities {
  int slope_positive = slope > 0 ? 1 : 0;
}