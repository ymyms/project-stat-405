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
  intercept ~ normal(0, 1);
  slope  ~ normal(0, 1);
  y ~ bernoulli_logit(intercept + slope * height);
}

generated quantities {
  int slope_positive = slope > 0 ? 1 : 0;  
  real p_pred = inv_logit(intercept + slope * height[N]);
}