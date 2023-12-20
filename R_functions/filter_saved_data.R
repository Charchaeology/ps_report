# filter_save_data.R

# Extracting species name from scientific name
merged_data$speciesName <- gsub(" .*", "", merged_data$scientificName)

# Defining list of suported species
species_sup <- c("Triticum", "Olea", "Zea", "Solanum", "Allium", "Capsicum", "Ocimum")

# Filtering the merged data based
filtered_data <- merged_data %>%
  filter(!is.na(Region_Name) & Region_Name != "") %>%
  filter(speciesName %in% species_sup)

# Mapping the species names to a more readable format
species_mapping <- c("Triticum" = "Triticum L.",
                     "Olea" = "Olea europaea L.",
                     "Zea" = "Zea mays L.",
                     "Solanum" = "Solanum lycopersicum L.",
                     "Allium" = "Allium cepa L.",
                     "Capsicum" = "Capsicum L.",
                     "Ocimum" = "Ocimum basilicum L.")

filtered_data$speciesName <- species_mapping[filtered_data$speciesName]

# Saving merged_data to the "Data" folder
write.csv(merged_data, here("Data", "merged_data.csv"), row.names = FALSE)

# Saving filtered_data to the "Data" folder
write.csv(filtered_data, here("Data", "filtered_data.csv"), row.names = FALSE)
