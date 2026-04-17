data {
  int<lower=0> N;
  vector<lower=0>[N] height;
  array[N] int<lower=0,upper=1> y;
  vector<lower=0>[N] age;
  vector<lower=0>[N] player_weight;
  vector<lower=0>[N] pts;
  vector<lower=0>[N] ast;
  vector<lower=0,upper=1>[N] ts_pct;
  
  real sd_height;
  real sd_weight;
  real sd_pts;
  real sd_ast;
  real sd_age;
  real sd_ts;
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
  intercept ~ normal(0, 1);
  slope_height ~ normal(0, sd_height);
  slope_weight ~ normal(0, sd_weight);
  slope_pts ~ normal(0, sd_pts);
  slope_ast ~ normal(0, sd_ast);
  slope_age ~ normal(0, sd_age);
  slope_ts~ normal(0, sd_ts);
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