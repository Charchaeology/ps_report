# sample_size_genus.R

# Scientific Names of the seven ingredients
species_of_interest <- c("Triticum L.", "Olea europaea L.", "Zea mays L.", "Solanum lycopersicum L.", "Allium cepa L.", "Capsicum L.", "Ocimum basilicum L.")

# Filtering the data for species_of_interest and calculating the counts
filtered_data1 <- filtered_data %>%
  filter(speciesName %in% species_of_interest) %>%
  group_by(speciesName) %>%
  summarise(count = n())

# Setting the plot width
options(repr.plot.width = 10) 

# Arranging the data by count in descending order
filtered_data1 <- filtered_data1 %>% 
  arrange(desc(count))

# Creating the plot
sample_number <- ggplot(filtered_data1, aes(x = reorder(speciesName, -count), y = count)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  geom_text(aes(label = count), vjust = -0.5, color = "black") +
  labs(title = "Number of Samples per Genus",
       x = "Species",
       y = "Number of Samples") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(b = 50)) 


# Printing the plot
print(sample_number)

# Saving the plot
ggsave(here("Data", "data_analysis", "samples_genus.png"), sample_number, width = 8, height = 6)