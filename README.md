# ps_report
Report for the Proseminar Geocomputation and Earth Observation

## Project Proposal
### 1. Abstract
One of the most popular dishes in Europe and around the world is probably pizza. Pizza can be made in all possible ways. It can be cheap, expensive, vegetarian, vegan, and much more. But the most common ingredients haven't always been local in Europe. However, most people are not aware of that. So this project aims to track the historical journey of some selected ingredients over continents and time. And then to present the result in an appealing animation.


### 2. Background and Motivation
Nowadays, with all kinds of food available year-round in supermarkets, we tend to forget that only a few centuries ago we didn't have them in Europe. Exploring the global history of the ingredients of a pizza helps us not only to enrich our understanding of the past but also to appreciate more the cultural diversity that has shaped our culinary experiences. The journey of food around the world isn't a new topic, as shown by the study [Origins of food crops connect countries worldwide](https://dx.doi.org/10.1098/rspb.2016.0792). In association with this study, a [website](https://blog.ciat.cgiar.org/origin-of-crops/) has been created to show plotted data, for example,
where food crops come from and where they are eaten now.



### 3. Objective
The goal of this project is to track the journey over time and over continents of some selected ingredients of the dish pizza. An easy-to-prepare dough contains water, salt, flour (mostly wheat), yeast, and olive oil ([Recipe](https://www.bettybossi.ch/de/Rezept/ShowRezept/BB_ITKU120801_0243A-40-de)). Possible vegetarian topics include corn, tomatoes, onions, paprika, cheese, and basil. For this project, only species are considered, as there is no data available on GBIF for processed food. The ingredients considered are: wheat (Triticum), olive (Olea europaea), corn (Zea mays), tomatoes (Solanum lycopersicum), onions (Allium cepa), paprika (Capsicum), and basil (Ocimum basilicum). This can change if the dataset for a chosen food isn't usable, when more food is added or ingredients are changed.
Further, this project tries to answer the question of when the selected ingredients were brought to a new continent by humans and where they came from. At the end, the journey of the ingredients around the world will be mapped and animated to have a more accessible and easier-to-understand result.
To prove feasibility, an example (see "Feasibility Example.Rmd") has been done using the dataset of the tomato (Solanum lycopersicum). The result of this example shows the project is doable and also helped to adjust the proposal.


### 4. Implementation
The implementation is going to be approached through the following steps executed in R:

 
#### 4.1 Data collection and cleaning
The following data is needed: Scientific name (taxonomic name), location (country), and year of the documentation of the chosen ingredients for tracking the historic journey. The Global Biodiversity Information Facility (GBIF; [@rgbif]) Database provides data from the year 1000 to 2023 for that. The datasets of GBIF provide more than the used data; the data set first needs to be filtered by the above-mentioned sections (name, location, year) of each ingredient and then cleaned.

 
#### 4.2 Processing of the Data
The data will be filtered by the earliest appearance of an ingredient on each continent. This will be executed on all chosen ingredients with the same filter (filtering by year and continent). Which countries are part of which continent will be defined by the geographical and historical-political order. The following continents will be considered: Europe, North America, South America, Asia, and Oceania. Antarctica will not be considered as there isn't enough data available on GBIF. Having the earliest appearance, the data needs to be merged with geographical data for plotting. For this, the package [@rnaturalearth] and the data [@rnaturalearthdata] are used. This data gets merged with the data of the earliest appearance and will then be plotted on a map showing all the appearances of an ingredient on a new continent. This is done for each ingredient.


 
#### 4.3 Animation
The created plots and maps will be animated with the [@gganimated] package. The application of the animations will be decided when Step 4.2 is done, so the best implementation can be chosen based on the resulted plots and maps.


### 5. Timeline
- [ ] Until 15.11. Data collection and cleaning (Step 4.1)
- [ ] Until 22.11. Processing (Step 4.2) 
- [ ] Until 06.12. Animation (Step 4.3)
- [ ] 06.12. Exchange code in class - feedback
- [ ] 13.12. Implement feedback in class
- [ ] 20.12. Presentation of the project in class


### 6. Risks and contingencies
* If there is missing data, first a data assessment needs to be done, and the impact needs to be considered. If the data isn't critical, data imputation can be considered or dismissed. When there is too much missing data for a chosen ingredient, the ingredient may be excluded or changed to another one. 
* The feasibility example showed that GBIF isn't always providing data for the years 1000 to 2023. For example, for the tomato, the dates start in 1737. That means the tracking will start where data is available (e.g., for tomatoes, starting in 2023). This will be discussed and highlighted during the project.
* The results can change depending on the decisions taken. For example, the definition of a continent or the definition of which country is part of which continent.
* The availability of data on GBIF depends a lot on the scientific stand, whether data is provided to GBIF and whether it meets the [standards of GBIF](https://www.gbif.org/what-is-gbif#:~:text=This%20knowledge%20derives%20from%20many,in%20recent%20days%20and%20weeks). So the first appearance date only represents the first appearance that is registered in the GBIF database.



### 7. Impact
This project can provide an insight into history and, moreover, into human migration, mobility, and trade. And additionally, raise awareness about what we eat nowadays and where the ingredients of food originate from.



