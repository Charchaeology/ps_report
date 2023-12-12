# Filtering for earliest apperance of Species per continent
for (species in species_of_interest) {
  
  # Filter data for the current species
  species_data <- filtered_data[filtered_data$scientificName == species, ]
  
  # Create an empty data frame to store results for each continent
  species_results <- data.frame()
  
  # Loop over each continent
  for (continent in unique(species_data$Region_Name)) {
    # Filter data for the current continent
    continent_data <- species_data[species_data$Region_Name == continent, ]
    
    # Find the earliest appearance year
    earliest_year <- min(continent_data$year, na.rm = TRUE)
    
    # Create a data frame with species, continent, and earliest year
    continent_result <- data.frame(
      species = species,
      continent = continent,
      earliest_year = earliest_year
    )
    
    # Append the result to the species_results data frame
    species_results <- rbind(species_results, continent_result)
  }
  
  # Append the results for the current species to the result_list
  result_list[[species]] <- species_results
  
  # Saving results to individual CSV files
  write.csv(species_results, file = paste0("../EAC_ingredients/EAC/", gsub(" ", "_", species), "_EAC.csv"), row.names = FALSE)
  
  # Print results for the current species
  print(species_results)
}