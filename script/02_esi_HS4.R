

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
df_esi <- df %>% 
  filter(tradeflowname == 'Export') %>% 
  select(year, reportername, reporteriso3, productcode, tradevalue) %>% 
  rename(
    partner = reportername,
    partneriso3 = reporteriso3,
    partner_exp = tradevalue
  ) %>% 
  arrange(year, partner, productcode)

india <- file0
colnames(india) <- tolower(colnames(india))
india <- india %>% 
  mutate(ind_exp = tradevalue.in.1000.usd * 1000) %>%  
  select(year, productcode, ind_exp) %>% 
  arrange(year, productcode)

# merging India's export data with partner dataframe
df_esi <- df_esi %>% 
  left_join(india, by = c('year', 'productcode'))
india_sub <- df_esi %>% filter(productcode == 101)  # sanity check

# calculating TCI
df_esi <- df_esi %>%
  group_by(year, partner) %>% 
  mutate(
    partner_total_exp = sum(partner_exp, na.rm = TRUE),
    ind_total_exp = sum(ind_exp, na.rm = TRUE),
    
    partner_exp_share = partner_exp/partner_total_exp,
    ind_exp_share = ind_exp/ind_total_exp,
    
    min_share = pmin(partner_exp_share, ind_exp_share),
    
    esi = 100 * sum(min_share, na.rm = TRUE)
  ) %>% 
  ungroup()

# extract tci
esi <- df_esi %>% 
  group_by(year, partner) %>%
  summarise(esi = first(esi), .groups = "drop") %>% 
  arrange(partner, year)

write.csv(esi, file = 'output/data/esi.csv')
