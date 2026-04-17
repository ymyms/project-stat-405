data {
  int<lower=0> N;
  vector<lower=0>[N] height;
  array[N] int<lower=0,upper=1> y;
  vector<lower=0>[N] age;
  vector<lower=0>[N] player_weight;
  vector<lower=0>[N] pts;
  vector<lower=0>[N] ast;
  vector<lower=0,upper=1>[N] ts_pct;
  
  real prior_center;
  real<lower=0>prior_sd;
  real prior_rate;
  
}

parameters {
  real intercept;
  real slope_height;
  real slope_weight;
  real slope_pts;
  real slope_ast;
  real slope_age;
  real slope_ts;
  real center;
  real<lower=0> spread;
}

model {
  center ~ normal(prior_center,prior_sd);
  spread ~ exponential(prior_rate);
  intercept ~ normal(0, 1);
  slope_height ~ normal(center, spread);
  slope_weight ~ normal(center, spread);
  slope_pts ~ normal(center, spread);
  slope_ast ~ normal(center, spread);
  slope_age ~ normal(center, spread);
  slope_ts ~ normal(center, spread);
  y ~ bernoulli_logit(intercept + 
                 slope_height * height + 
                 slope_age * age + 
                 slope_weight * player_weight + 
                 slope_pts * pts + 
                 slope_ast * ast + 
                 slope_ts * ts_pct);
}

generated quantities {
  int height_slope_positive =  slope_height > 0 ? 1 : 0;
}