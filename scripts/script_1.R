library(tidyverse)
library(priorexposure)

# Data
# m heads in n coin flips
m <- 139
n <- 250

bernoulli_likelihood(n, m)

m <- 14
n <- 25

bernoulli_likelihood(n, m)

b_alpha <- 3
b_beta <- 5

beta_plot(b_alpha, b_beta)
beta_plot(alpha = 5, beta = 3)
beta_plot(alpha = 10, beta = 3)
beta_plot(alpha = 3, beta = 3)
beta_plot(alpha = 10, beta = 10)
beta_plot(alpha = 25, beta = 25)
beta_plot(alpha = 1000, beta = 1500)

beta_plot(alpha = 1, beta = 1)
beta_plot(alpha = 0.1, beta = 0.1)

n <- 250
m <- 139
bernoulli_posterior_plot(n, m, 
                         alpha = b_alpha, 
                         beta = b_beta)

bernoulli_posterior_summary(n, m, b_alpha, b_beta)

get_beta_hpd(m + b_alpha, n - m + b_beta)

# uniform prior
bernoulli_posterior_plot(n, m, 
                         alpha = 1, 
                         beta = 1)

bernoulli_posterior_summary(n, m, 
                            alpha=1, 
                            beta=1)

# draw many samples from the Beta posterior
# where prior is beta(1,1)
s <- rbeta(1e6, shape1 = m + 1, shape2 = n - m + 1)
mean(s)
sd(s)
quantile(s, probs = c(0.025, 0.975))
