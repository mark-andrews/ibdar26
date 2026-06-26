# brms formula
# ↓
# brms-generated Stan code
# ↓
# CmdStan translates Stan to C++
# ↓
# C++ compiler builds a model-specific executable
# ↓
# CmdStan runs NUTS/HMC using that executable
# ↓
# cmdstanr reads results back into R

# brms formula
# ↓
# brms-generated Stan code
# ↓
# rstan translates Stan to C++
#   ↓
# C++ compiler builds an R-loadable DLL/shared object
# ↓
# R loads it through Rcpp
# ↓
# rstan runs NUTS/HMC inside the R process

install.packages(
  "cmdstanr",
  repos = c("https://stan-dev.r-universe.dev", "https://cloud.r-project.org")
)

cmdstanr::check_cmdstan_toolchain()
cmdstanr::install_cmdstan()


library(brms)

options(brms.backend = "cmdstanr")

data_df <- tibble::tibble(x = rnorm(10))

M <- brm(
  x ~ 1,
  data = data_df,
  chains = 2,
  # cores = 2,
  backend = "cmdstanr"
)

M1 <- brm(
  x ~ 1,
  family = student(),
  data = data_df,
  chains = 2,
  # cores = 2,
  # backend = "cmdstanr"
)
