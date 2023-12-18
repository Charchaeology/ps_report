# merge_data.R
problematic_rows <- apply(UNSD_M49_split, 1, function(row) any(is.na(row)))
UNSD_M49_c <- UNSD_M49[complete.cases(UNSD_M49), ]

merged_data <- merge(combined_data_e, UNSD_M49_split, by.x = "countryCode", by.y = "ISO_alpha2_Code", all.x = TRUE)

merged_data$Region_Name <- ifelse(merged_data$Region_Name == "Americas", merged_data$Subregion_Name, merged_data$Region_Name)

# Remove Subregion_Name column if it's no longer needed
merged_data <- merged_data[, !(names(merged_data) %in% c("Subregion_Name"))]

merged_data$Region_Name <- ifelse(merged_data$Region_Name == "Latin America and the Caribbean", "South America", merged_data$Region_Name)
merged_data$Region_Name <- ifelse(merged_data$Region_Name == "Northern America", "North America", merged_data$Region_Name)

merged_data <- merged_data[, c("countryCode", "X", "scientificName", "year", "Region_Name")]
