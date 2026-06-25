library(tidyverse)
library(brms)

source("https://raw.githubusercontent.com/mark-andrews/ibdar/refs/heads/ibdar25/data/dl_data.R")
source("https://raw.githubusercontent.com/mark-andrews/ibdar/refs/heads/ibdar25/data/sim_data.R")

# Classical/frequentist linear regression using lm()
M_1 <- lm(y ~ x_1 + x_2, data = data_df1)

summary(M_1)
summary(M_1)$coef
sigma(M_1)
confint(M_1)

M_2 <- brm(y ~ x_1 + x_2,
           backend = 'cmdstanr',
           data = data_df1)

# check your cores
parallel::detectCores(logical = FALSE)

M_2
summary(M_2)
fixef(M_2)

plot(M_2)
mcmc_plot(M_2)
mcmc_plot(M_2, type = 'intervals')
mcmc_plot(M_2, type = 'hist')
mcmc_plot(M_2, type = 'hist', variable = 'sigma')
mcmc_plot(M_2, type = 'hist', 
          variable = c("b_Intercept", "b_x_1"))
mcmc_plot(M_2, type = 'areas')
mcmc_plot(M_2, type = 'areas_ridges')
mcmc_plot(M_2, type = 'dens')
mcmc_plot(M_2, type = 'dens_chains',
          variable = 'sigma')


as_draws_df(M_2)
stancode(M_2)

prior_summary(M_2)

M_3 <- lm(weight ~ height + gender, data = weight_df)
summary(M_3)

M_4 <- brm(weight ~ height + gender, data = weight_df,
           backend = 'cmdstanr')
