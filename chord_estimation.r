library(tidyverse)
library(plotly)
library(Cairo)
library(ggtext)
source("compmus.R")
library(rjson)

chroma1 <- compmus_chroma("mees-k-1.json", norm = "identity") %>% 
  mutate(song = "mees-k-1")
chroma2 <- compmus_chroma("mees-k-2.json", norm = "identity") %>% 
  mutate(song = "mees-k-2")

major_chord <- c(1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0)
minor_chord <- c(1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0)
chord_templates <- tribble(
  ~name,   ~template,
  "D:min", circshift(minor_chord, 2),
  "F:maj", circshift(major_chord, 5),
  "A:min", circshift(minor_chord, 9),
  "C:maj", circshift(major_chord, 0),
  "E:min", circshift(minor_chord, 4),
  "G:maj", circshift(major_chord, 7),
  "B:min", circshift(minor_chord, 11)
)

chord_match_1 <- compmus_match_pitch_templates(chroma1, chord_templates, norm = "identity", distance = "cosine") %>% 
  mutate(song = "mees-k-1")
chord_match_2 <- compmus_match_pitch_templates(chroma2, chord_templates, norm = "identity", distance = "cosine") %>% 
  mutate(song = "mees-k-2")
chord_matches <- bind_rows(chord_match_1, chord_match_2)

pl_chords <- ggplot(chord_matches, aes(x = time, y = name, fill = d)) +
  geom_tile() +
  scale_fill_viridis_c() +
  labs(x = "Time (s)", y = "Chord", title = "Chord Estimation for My Songs") +
  facet_wrap(~ song, ncol = 1) +
  theme_minimal()

ggplotly(pl_chords)

