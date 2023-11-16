##Function list 
# Find Earliest Appearance of a species
function(data, continent_name, country_codes, species_name) {
  continent_data <- data %>%
    filter(countryCode %in% country_codes, scientificName == species_name)
  
  earliest_appearance <- continent_data %>%
    group_by(scientificName) %>%
    summarize(first_appearance = min(year))
  
  if (nrow(earliest_appearance) > 0) {
    cat("Continent:", continent_name, "\n")
    cat("Species:", species_name, "\n")
    cat("Earliest Appearance:", earliest_appearance$first_appearance, "\n\n")
  }
}
