

options(scipen = 999)

library(tidyverse)
library(ggrepel)


# importing the data
tci <- read.csv('output/data/tci.csv')
esi <- read.csv('output/data/esi.csv')

df <- tci %>% 
  left_join(esi, by = c('year', 'partner')) %>% 
  select(year, partner, tci, esi) %>% 
  arrange(partner, year)

# scatterplot
df_2023 <- df %>% filter(year == 2023)

ggplot(df_2023, aes(x = tci, y = esi, label = partner)) +
  geom_point(size = 3) +
  geom_text_repel(size = 4) +  # moves country label above the dot
  
  # add quadrant lines at 50
  geom_vline(xintercept = 50, linetype = 'dashed') +
  geom_hline(yintercept = 50, linetype = 'dashed') +
  
  coord_cartesian(xlim = c(0, 100), ylim = c(0, 100)) +  # stop default zoom-in
  
  # adds quadrant labels
  annotate('text', x = 85, y = 90, label = 'High TCI\nHigh ESI', size = 4) +
  annotate('text', x = 15, y = 90, label = 'Low TCI\nHigh ESI', size = 4) +
  annotate('text', x = 85, y = 10, label = 'High TCI\nLow ESI', size = 4) +
  annotate('text', x = 15, y = 10, label = 'Low TCI\nLow ESI', size = 4) +
  
  labs(
    title = 'TCI vs ESI (HS4) – 2023',
    x = 'Trade Complementarity Index (TCI)',
    y = 'Export Similarity Index (ESI)'
  ) +
  theme_minimal()

# line plots

# tci
ggplot(df, aes(x = year, y = tci, color = partner)) +
  geom_point(size = 2) +
  geom_line(linewidth = 1) +
  
  coord_cartesian(ylim = c(10, 80)) +  # stop default zoom-in
  
  labs(
    title = 'Trade Complementarity Index (HS4)',
    x = 'Year',
    y = 'TCI (HS4)',
    color = 'Partner Country'
  ) +
  theme_minimal()

# esi
ggplot(df, aes(x = year, y = esi, colour = partner)) +
  geom_point(size = 2) +
  geom_line(linewidth = 1) +
  
  coord_cartesian(ylim = c(0, 80)) +  # stop default zoom-in
  
  labs(
    title = 'Export Similarity Index (HS4)',
    x = 'Year',
    y = 'ESI (HS4)',
    colour = 'Partner Country'
  ) +
  theme_minimal()


# line plots per country (facet wrap)

# tci
ggplot(df, aes(x = year, y = tci)) +
  geom_line(color = 'steelblue', linewidth = 1) +
  geom_point(size = 2) +
  
  facet_wrap(~ partner) +
  
  labs(
    title = 'TCI (HS4) by Partner',
    x = 'Year',
    y = 'TCI (HS4)'
  ) +
  theme_minimal()

#esi
ggplot(esi, aes(x = year, y = esi)) +
  geom_line(color = 'steelblue', linewidth = 1) +
  geom_point(size = 2) +
  
  facet_wrap(~ partner) +
  
  labs(
    title = 'ESI (HS4) by Partner',
    x = 'Year',
    y = 'ESI (HS4)'
  ) +
  theme_minimal()
