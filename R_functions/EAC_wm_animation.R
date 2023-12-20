# EAC_wm_animation.R
create_species_map <- function(species_name) {
  
  # Reading the corresponding EAC CSV file
  species_result <- read.csv(file.path("..", "EAC_ingredients", "EAC", paste0(gsub(" ", "_", species_name), "_EAC.csv")))
  
  # Ordering the data frame by EarliestAppearance in ascending order
  species_result <- species_result %>% arrange(earliest_year)
  
  # Getting the order of continents based on the first appearance year
  continent_order <- species_result %>%
    group_by(continent) %>%
    summarize(first_appearance = min(earliest_year)) %>%
    arrange(first_appearance) %>%
    pull(continent)
  
  # Defining custom order for y-axis
  custom_order <- continent_order
  
  # Creating a factor variable for Continent with the custom order
  species_result$continent <- factor(species_result$continent, levels = custom_order)
  
  # Creating the animated map using gganimate
  animated_map <- ggplot() +
    borders("world", colour = "gray85", fill = "gray80") +
    geom_sf(data = merge(world, species_result, by.x = "continent", by.y = "continent"), 
            aes(fill = as.numeric(earliest_year))) +  
    scale_fill_viridis_c() + 
    labs(title = paste(species_name),
         fill = "Year of First \nAppearance") +
    theme_minimal() +
    theme(plot.background = element_rect(fill = "white"),
          legend.background=element_blank(),
          axis.title=element_blank(),
          legend.key.size = unit(0.6, 'cm'),
          legend.title=element_text(size=9), 
          legend.text=element_text(size=8)) +
    coord_sf(label_axes = "both") +
    transition_states(states = earliest_year, transition_length = 2, state_length = 1) +
    labs(subtitle = 'Year: {closest_state}')
  
  
  # Define animated_map_filename
  animated_map_filename <- file.path("..", "EAC_ingredients", "maps", paste0(gsub(" ", "_", species_name), "_animated.gif"))
  
  
  # Saving the animated map directly
  tryCatch({
    anim_save(animated_map_filename, animation = animated_map)
  }, error = function(e) {
    cat("Error saving animated map:", e$message, "\n")
  })
}