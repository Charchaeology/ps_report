# Loading world data
world <- ne_countries(scale = "medium", returnclass = "sf")

# Standardizing continent names in world data
world <- world %>%
  mutate(region_un = case_when(
    region_un %in% c("Asia", "Oceania", "South America", "North America", "Africa", "Europe") ~ region_un,
    TRUE ~ "Other"
  ))

# Function to animate the EAC on the world map
create_species_map <- function(species_name) {
  
  # Reading the corresponding EAC CSV file
  species_result <- read.csv(here("EAC_ingredients", "EAC", paste0(gsub(" ", "_", species_name), "_EAC.csv")))
  
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
  
  # Merging species_result data frame with continent boundaries
  merged_data <- merge(world, species_result, by.x = "continent", by.y = "continent")
  
  # Creating the map
  map_plot  <-  ggplot() +
    borders("world", colour = "gray85", fill = "gray80") +
    geom_sf(data = merged_data,aes(fill = earliest_year)) +
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
    coord_sf(label_axes = "both")
  
  # Printing the map plot
  print(map_plot)
  
  # Creating a folder for each species
  species_folder <- here("EAC_ingredients", "maps", "EAC_", gsub(" ", "_", gsub("\\.", "", species_name)), "/")
  dir.create(species_folder, showWarnings = FALSE)
  
  # Saving the map plot
  ggsave(paste0(species_folder, "earliest_appearance.png"), plot = map_plot, width = 8, height = 6)
  
  # Animating the map
  animated_map  <-  map_plot +
    transition_manual(frames=earliest_year,cumulative = TRUE) +
    labs(title = paste(species_name),
         subtitle = 'Year: {current_frame}')
  
  # Calculate fps based on the total number of unique years
  total_frames <- length(unique(species_result$earliest_year))
  fps_factor <- if (total_frames > 0) 100 / total_frames else 1
  
  
  # Printing the map plot
  print(animated_map)
  
  # Saving the map plot
  anim_save(here(species_folder, "animated_map.gif"), plot = animated_map, width = 8, height = 6)
  
}