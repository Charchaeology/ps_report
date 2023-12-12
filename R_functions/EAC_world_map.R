# Function to plot the EAC on a world map

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
  map_plot <- ggplot(merged_data) +
    geom_sf(aes(fill = factor(earliest_year))) +
    scale_fill_brewer(palette = 1) +
    labs(title = paste(species_name),
         fill = "Year of Earliest Appearance per continent") +
    theme_minimal() +
    theme(plot.background = element_rect(fill = "white")) +
    coord_sf(label_axes = "both")
  
  print(map_plot)
  
   # Creating a folder for each species
  species_folder <- here("EAC_ingredients", "maps", paste0("EAC_", gsub(" ", "_", gsub("\\.", "", species_name))))
  dir.create(species_folder, showWarnings = FALSE)
  
  # Saving the map plot
  ggsave(here(species_folder, "earliest_appearance.png"), plot = map_plot, width = 8, height = 6)
}

# Apply the function to each species
# lapply(species_of_interest, create_species_map)

