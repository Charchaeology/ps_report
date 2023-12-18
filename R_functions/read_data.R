# read_data.R
combined_data <- read.csv(here("Data_ingredients", "cleaned", "combined_data.csv"))
UNSD_M49 <- read.csv(here("Data", "UNSD_M49.csv"))

# Separate UNSD_M49 data frame by semicolon
UNSD_M49_split <- separate(data = UNSD_M49,
                           col = "Region_Code.Region.Name.Sub.region.Code.Sub.region.Name.ISO_alpha2_Code",
                           into = c("Region_Code", "Region_Name", "Subregion_Code", "Subregion_Name", "ISO_alpha2_Code"),
                           sep = ";", fill = "right", convert = TRUE)

# Remove rows with NA in countryCode
combined_data_e <- combined_data[complete.cases(combined_data$countryCode), ]
