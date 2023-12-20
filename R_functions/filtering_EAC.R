# filtering_EAC.R

# Creating an empty list to store results for each species
result_list <- list()

# Function for filtering for EAC
for (species in species_of_interest) {
  
  # Filtering data for the current species
  species_data <- filtered_data[filtered_data$speciesName == species, ]
  
  # Creating an empty data frame to store results for each continent
  species_results <- data.frame()
  
  # Looping over each continent
  for (continent in unique(species_data$Region_Name)) {
    # Filtering data for the current continent
    continent_data <- species_data[species_data$Region_Name == continent, ]
    
    # Finding the earliest appearance year
    earliest_year <- min(continent_data$year, na.rm = TRUE)
    
    # Creating a data frame with species, continent, and earliest year
    continent_result <- data.frame(
      species = species,
      continent = continent,
      earliest_year = earliest_year
    )
    
    # Appending the result to the species_results data frame
    species_results <- rbind(species_results, continent_result)
  }
  
  # Appending the results for the current species to the result_list
  result_list[[species]] <- species_results
  
  # Saving results to individual CSV files
  dir_path <- here("EAC_ingredients", "EAC")
  
  file_name <- paste0(gsub(" ", "_", species), "_EAC.csv")
  file_path <- file.path(dir_path, file_name)
  
  if (!dir.exists(dir_path)) dir.create(dir_path, recursive = TRUE)
  
  write.csv(species_results, file = file.path(dir_path, file_name), row.names = FALSE)
  
  # Printing results for the current species
  print(species_results)
}


