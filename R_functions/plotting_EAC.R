# plotting_EAC.R
# Creating an empty list to store plots for each species
plot_list <- list()

# Function to plot the EAC
for (species_name in species_of_interest) {
  
  
  # Reading the CSV file
  species_results <- read.csv(here("EAC_ingredients/EAC/", paste0(gsub(" ", "_", species_name), "_EAC.csv")))
  
  
  # Ordering the data frame by the earliest year in ascending order
  species_results <- species_results %>% arrange(earliest_year)
  
  # Getting the order of continents based on the first appearance year
  continent_order <- species_results %>%
    group_by(continent) %>%
    summarize(first_appearance = min(earliest_year)) %>%
    arrange(first_appearance) %>%
    pull(continent)
  
  # Defining custom order for y axis
  custom_order <- continent_order
  
  # Creating a factor variable for Continent with the custom order
  species_results$continent <- factor(species_results$continent, levels = custom_order)
  
  # Creating a timeline plot
  timeline_plot <- ggplot(species_results, aes(x = earliest_year, y = factor(continent, levels = custom_order))) +
    geom_segment(aes(xend = earliest_year, yend = factor(continent, levels = custom_order)), color = "skyblue") +
    geom_point(size = 3, color = "darkblue") +
    labs(title = paste("Timeline of Earliest Appearance of", species_name), x = "Year", y = "Continent") +
    theme_minimal()
  
  # Saving the plot as a PNG file
  ggsave(here("EAC_ingredients", "timeline_plots", paste0(species_name, "_timeline.png")), timeline_plot, width = 8, height = 6)
  
  # Printing the plot for the current species
  print(timeline_plot)
}