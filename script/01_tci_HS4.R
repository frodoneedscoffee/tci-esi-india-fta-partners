

options(scipen = 999)

library(tidyverse)


# importing the data
file0 <- read.csv('data/india-exports-2017to2024-HS4.csv')
file1 <- read.csv('data/fta-australia-uae-2017to2024-HS2017-HS4.csv')
file2 <- read.csv('data/fta-skorea-nz-2017to2024-HS2017-HS4.csv')
file3 <- read.csv('data/fta-uk-oman-2017to2024-HS2017-HS4.csv')

df <- bind_rows(file1, file2, file3)
colnames(df) <- tolower(colnames(df))
df <- df %>% 
  mutate(tradevalue = tradevalue.in.1000.usd * 1000) %>% 
  select(-tradevalue.in.1000.usd)

write.csv(df, file = 'data/india-fta-2017to2024-HS2017-HS4.csv')

# selecting required data
df_tci <- df %>% 
  filter(tradeflowname == 'Import') %>% 
  select(year, reportername, reporteriso3, productcode, tradevalue) %>% 
  rename(
    partner = reportername,
    partneriso3 = reporteriso3,
    partner_imp = tradevalue
  ) %>% 
  arrange(year, partner, productcode)

india <- file0
colnames(india) <- tolower(colnames(india))
india <- india %>% 
  mutate(ind_exp = tradevalue.in.1000.usd * 1000) %>%  
  select(year, productcode, ind_exp) %>% 
  arrange(year, productcode)

# merging India's export data with partner dataframe
df_tci <- df_tci %>% 
  left_join(india, by = c('year', 'productcode'))
india_sub <- df_tci %>% filter(productcode == 101)  # sanity check

# calculating TCI
df_tci <- df_tci %>%
  group_by(year, partner) %>% 
  mutate(
    partner_total_imp = sum(partner_imp, na.rm = TRUE),
    ind_total_exp = sum(ind_exp, na.rm = TRUE),
    
    partner_imp_share = partner_imp/partner_total_imp,
    ind_exp_share = ind_exp/ind_total_exp,
    
    abs_diff = abs(partner_imp_share - ind_exp_share),
    
    tci = 100 * (1 - (sum(abs_diff, na.rm = TRUE) / 2))
    ) %>% 
  ungroup()

# extract tci
tci <- df_tci %>% 
  group_by(year, partner) %>%
  summarise(tci = first(tci), .groups = "drop") %>% 
  arrange(partner, year)

write.csv(tci, file = 'output/data/tci.csv')
