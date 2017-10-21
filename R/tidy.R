rm(list=ls())
library(tidyverse)

data <- read.csv('data/wta_matches_2017.csv')
dim(data)
str(data)

data %>% filter(is.na(minutes))

winner_data <- data %>% 
  rename(
    S1stIn = w_1stIn, 
    S1stWon = w_1stWon, 
    S2ndWon = w_2ndWon, 
    SvGms = w_SvGms, 
    ace = w_ace, 
    bpFaced = w_bpFaced, 
    bpSaved = w_bpSaved, 
    df = w_df, 
    svpt = w_svpt, 
    age = winner_age, 
    entry = winner_entry, 
    hand = winner_hand, 
    ht = winner_ht, 
    id = winner_id, 
    ioc = winner_ioc, 
    name = winner_name, 
    rank = winner_rank, 
    rank_points = winner_rank_points, 
    seed = winner_seed,
    opponent = loser_name,
    Op_S1stIn = l_1stIn, 
    Op_S1stWon = l_1stWon, 
    Op_S2ndWon = l_2ndWon, 
    Op_SvGms = l_SvGms, 
    Op_ace = l_ace, 
    Op_bpFaced = l_bpFaced, 
    Op_bpSaved = l_bpSaved, 
    Op_df = l_df, 
    Op_svpt = l_svpt, 
    Op_age = loser_age, 
    Op_entry = loser_entry, 
    Op_hand = loser_hand, 
    Op_ht = loser_ht, 
    Op_id = loser_id, 
    Op_ioc = loser_ioc, 
    Op_rank = loser_rank, 
    Op_rank_points = loser_rank_points, 
    Op_seed = loser_seed) %>% mutate(Win = 1)
  

loser_data <- data %>% 
  rename(
    S1stIn = l_1stIn, 
    S1stWon = l_1stWon, 
    S2ndWon = l_2ndWon, 
    SvGms = l_SvGms, 
    ace = l_ace, 
    bpFaced = l_bpFaced, 
    bpSaved = l_bpSaved, 
    df = l_df, 
    svpt = l_svpt, 
    age = loser_age, 
    entry = loser_entry, 
    hand = loser_hand, 
    ht = loser_ht, 
    id = loser_id, 
    ioc = loser_ioc, 
    name = loser_name, 
    rank = loser_rank, 
    rank_points = loser_rank_points, 
    seed = loser_seed,
    opponent = winner_name,
    Op_S1stIn = w_1stIn, 
    Op_S1stWon = w_1stWon, 
    Op_S2ndWon = w_2ndWon, 
    Op_SvGms = w_SvGms, 
    Op_ace = w_ace, 
    Op_bpFaced = w_bpFaced, 
    Op_bpSaved = w_bpSaved, 
    Op_df = w_df, 
    Op_svpt = w_svpt, 
    Op_age = winner_age, 
    Op_entry = winner_entry, 
    Op_hand = winner_hand, 
    Op_ht = winner_ht, 
    Op_id = winner_id, 
    Op_ioc = winner_ioc, 
    Op_rank = winner_rank, 
    Op_rank_points = winner_rank_points, 
    Op_seed = winner_seed    
  ) %>% mutate(Win = 0)


tidyied_data <- rbind(winner_data, loser_data)
dim(tidyied_data)
str(tidyied_data)

write.csv(tidyied_data, 'data/tidy_dataset_wta_2017.csv')
