data {
  int<lower=0> N_tall;
  int<lower=0> N_short;
  array[N_tall] int<lower=0,upper=1> y_tall;
  array[N_short] int<lower=0,upper=1> y_short;
}

parameters {
  real<lower=0,upper=1> mu;
  real<lower=0> s;
  real<lower=0,upper=1> p_tall;
  real<lower=0,upper=1> p_short;
}

model {
  mu ~ beta(1, 1);
  s ~ exponential(1);
  p_tall ~ beta_proportion(mu, s);
  p_short ~ beta_proportion(mu, s);
  y_tall ~ bernoulli(p_tall);
  y_short ~ bernoulli(p_short);
}

generated quantities {
   real is_taller_sooner_drafted = p_tall > p_short ? 1 : 0;
}