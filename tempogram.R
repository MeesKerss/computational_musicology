library(tidyverse)
library(plotly)
library(Cairo)
library(ggtext)
source("compmus.R")
library(rjson)

tempogram1 <- compmus_tempogram("mees-k-1.json", window_size = 8, hop_size = 1, cyclic = TRUE) %>% 
  mutate(song = "mees-k-1")

tempogram2 <- compmus_tempogram("mees-k-2.json", window_size = 8, hop_size = 1, cyclic = TRUE) %>% 
  mutate(song = "mees-k-2")

tempograms <- bind_rows(tempogram1, tempogram2)

p <- ggplot(tempograms, aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  facet_wrap(~ song, ncol = 1) +
  labs(
    title = "Tempogram of My Songs",
    x = "Time (s)",
    y = "Tempo (BPM)"
  ) +
  theme_classic()

p <- ggplotly(p)

saveRDS(p, "tempogram.rds")
