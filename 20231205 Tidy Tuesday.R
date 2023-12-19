library(htmlwidgets)
library(plotly)
library(dplyr)
library(readr)
library(htmltools)


life_expectancy <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy.csv')

le_df <- life_expectancy

le_df_filtered <- le_df %>%
  filter(Year >= 1950, Year <= 2021)

#Animation Speed
frame_duration <- 200
transition_duration <- 200


#Graph
le_graph <- plot_geo(le_df_filtered, locations = ~Entity, 
                     locationmode = 'country names', 
                     frame = ~Year) %>%
  add_trace(z = ~LifeExpectancy, 
            colors = 'Blues', 
            text = ~paste(le_df_filtered$Entity, ":", le_df_filtered$LifeExpectancy),
            zmin = min(le_df_filtered$LifeExpectancy, na.rm = TRUE),
            zmax = max(le_df_filtered$LifeExpectancy, na.rm = TRUE),
            color = ~LifeExpectancy,
            colorscale = 'Cividis') %>%
  animation_opts(frame_duration, transition_duration) %>%
  layout(
    title = list(
      text = 'Global Life Expectancy from 1950 to 2021',
      x = 0.5, 
      y = 0.95)
  )

le_graph

#Save as html
htmlwidgets::saveWidget(le_graph, "life_expectancy_animation.html", selfcontained = TRUE)



