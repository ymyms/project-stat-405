data {
  int<lower=0> N_tall;
  int<lower=0> N_short;
  array[N_tall] int<lower=0,upper=1> y_tall;
  array[N_short] int<lower=0,upper=1> y_short;
}

parameters {
  real<lower=0,upper=1> p_tall;
  real<lower=0,upper=1> p_short;
}

model {
  p_tall ~ beta(1, 1);
  p_short ~ beta(1, 1);

  y_tall ~ bernoulli(p_tall);
  y_short ~ bernoulli(p_short);
}

generated quantities {
   real is_taller_sooner_drafted = p_tall > p_short ? 1 : 0;
}