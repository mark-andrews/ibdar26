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

get_prior(weight ~ height + gender, 
           data = weight_df,
           backend = 'cmdstanr')

M_3 <- lm(weight ~ height + gender, data = weight_df)
summary(M_3)

M_4 <- brm(weight ~ height + gender, 
           data = weight_df,
           backend = 'cmdstanr')

M_5 <- brm(weight ~ height + gender, 
           data = weight_df,
           prior = set_prior("normal(0, 10)"),
           backend = 'cmdstanr')

prior_summary(M_5)


M_6 <- brm(weight ~ height + gender, 
           data = weight_df,
           prior = set_prior("normal(0, 10)", class = 'b', coef = 'height'),
           backend = 'cmdstanr')
prior_summary(M_6)
 
fixef(M_4)
fixef(M_6)

new_priors <- c(
 set_prior("normal(0, 10)", class = 'b', coef = 'height'),
 set_prior("normal(0, 50)", class = 'b', coef = 'gendermale'),
 set_prior("student_t(5, 80, 20)", class = 'Intercept'),
 set_prior("student_t(1, 0, 20)", class = 'sigma')
)

s <- rt(1e6, df = 5) * 20 + 80
quantile(s, probs = c(0.005, 0.995))

s <- rt(1e6, df = 1) * 20 
quantile(abs(s), probs = c(0.005, 0.5, 0.75, .9, 0.995))

M_7 <- brm(weight ~ height + gender, 
           data = weight_df,
           prior = new_priors,
           backend = 'cmdstanr')

fixef(M_7)
fixef(M_4)
summary(M_7)
summary(M_4)

M_8 <- lm(weight ~ height + gender, data = weight_df)
summary(M_8)$r.sq

var(predict(M_8)) / var(weight_df$weight)

bayes_R2(M_7)

M_9 <- lm(weight ~ height + gender + age, data = weight_df)

anova(M_8, M_9)
summary(M_9)$coef

AIC(M_8)
AIC(M_9)
AIC(M_8) - AIC(M_9) # Delta AIC
-2 * logLik(M_8) + 2*4 # -2 LL + 2K
-2 * logLik(M_9) + 2*5 # -2 LL + 2K



M_10 <- brm(weight ~ height + gender, 
            save_pars = save_pars(all=TRUE),
            data = weight_df)

M_11 <- brm(weight ~ height + gender + age, 
            save_pars = save_pars(all=TRUE),
            data = weight_df)

loo(M_10)
loo(M_11)

loo(M_10, M_11)

44694.5 - 44270.1 # DELTA looic 
-212.2 * -2

waic(M_10, M_11)

# Posterior predictive checks
pp_check(M_11)
pp_check(M_11, ndraws = 100)


ggplot(weight_df, aes(x = height, y = weight, colour = gender)) +
  geom_point(size = 0.5, alpha = 0.5) +
  geom_smooth(method = 'lm', fullrange = T) + 
  theme_classic()
