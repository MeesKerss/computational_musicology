knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(plotly)
library(Cairo)
library(ggtext)
source("compmus.R")
library(rjson)

"mees-k-1.json" |>
  compmus_tempogram(window_size = 8, hop_size = 1, cyclic = TRUE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)") +
  theme_classic()

```

***
  
  Template