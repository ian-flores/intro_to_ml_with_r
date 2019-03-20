library(tidyverse)

fifa_data <- read_csv('data/data.csv')

fifa_data %>%
    select(
        Name, Age, Nationality, Overall,
        Position, Finishing, ShortPassing,
         LongPassing, Acceleration, SprintSpeed, 
        Agility, Balance, ShotPower, Jumping, 
        Stamina, Strength) %>%
    filter(Position != 'GK') %>%
    mutate(quality_level = if_else(Overall > quantile(Overall, 0.80), 'A', 
                                   if_else(Overall > quantile(Overall, 0.60), 'B', 
                                           if_else(Overall > quantile(Overall, 0.40), 'C', 
                                                   if_else(Overall > quantile(Overall, 0.20), 'D', 'F'))))) %>%
    select(-Overall) -> fifa_data

table(fifa_data$quality_level)

fifa_data %>%
    filter(quality_level != 'F') %>%
    group_by(quality_level) %>%
    sample_n(1000) %>%
    write_csv('data/fifa_players.csv')
