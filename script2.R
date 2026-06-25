library(tidyverse)
library(brms)

source("https://raw.githubusercontent.com/mark-andrews/ibdar/refs/heads/ibdar25/data/dl_data.R")
source("https://raw.githubusercontent.com/mark-andrews/ibdar/refs/heads/ibdar25/data/sim_data.R")

# Classical/frequentist linear regression using lm()
M_1 <- lm(y ~ x_1 + x_2, data = data_df1)

summary(M_1)
