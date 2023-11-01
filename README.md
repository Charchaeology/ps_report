# ps_report
Report for the Proseminar Geocomputation and Earth Observation

## Project Proposal
### 1. Abstract
One of the most popular dishes in Europe and around the world is probably pizza. Pizza can be made in all possible ways. It can be cheap, expensive, vegetarian, vegan or so much more. But the most common ingredients haven't always been local in Europe. However, most people are not aware of that. So this project aims to track the historical journey of some selected ingredients over continents and time. And then present the result in an appealing animation.


### 2. Background and Motivation
Nowadays, having all kinds of food all year round available in the supermarkets, we tend to forget that only a few centuries ago we didn't have them in Europe. Exploring the global history of the ingredients of a pizza helps us not only to enrich our understanding of the past, but also to appreciate more the cultural diversity that has shaped our culinary experiences.



### 3. Objective
The goal of this project is to track the journey over time and over continents of some selected ingredients of the dish pizza. An easy to prepare dough contains water, salt, flour (mostly wheat), yeast, and olive oil. Possible vegetarian topics can be corn, tomatoes, onions, paprika and cheese. For this project, only unprocessed food can be considered, because of the limited project size. So the considered foods are: wheat (Triticum L.), olive (Olea europaea L.), corn (Zea mays L.), tomatoes (Solanum lycopersicum L.), onions (Allium cepa L.) and paprika (Capsicum L.). This can change, if the dataset for a chosen food isn't suitable or when more food is added.
Further, this project tries to answer the question when the selected ingredients were brought to a new continent by humans and where they came from. At the end, the journey of the ingredients around the world and especially to Europe will be mapped and animated, to make the results more accessible and easier to understand.


### 4. Implementation
The Implementation is going to be approached through the following steps:
 
#### 4.1 Data collection and cleaning
The following data is needed: Scientific name (taxonomic name), location (country) and year of the documentation of the chosen ingredients for tracking the historic journey. Those data is provided by the Global Biodiversity Information Facility (GBIF; [@rgbif]) Database, where data from the year 1000 to 2023 is secured. As the datasets of GBIF are providing more than the used data, the data set first needs to be filtered by the above-mentioned sections (name, location, year) of each ingredient and then cleaned.
To define the continents, geographical data is needed. That the datasets can be linked, the common identifier country is needed. Besides the country, data providing the information which country is part of which continent is important. So for the mapping the database [@rnaturalearth] is used, here only country boundaries are provided so continent-level boundaries need to be created by grouping and summarizing the countries.

 
#### 4.2 Processing of the data
The two prepared datasets (ingredients and geographical data) will be merged in this step. That means the dataset with species, location and time, gets expanded to the column continent. The data then will be filtered by the earliest appearance of an ingredient on each continent. This will be executed on all ingredients with the same filter. Each ingredient and every new appearance on a continent will then be plotted individually.

 
#### 4.3 Animation
All the created plots of an ingredient will be animated with the [@gganimated] package.


### 5. Timeline
- [ ] Until 01.11. Data collection and cleaning (Step 4.1)
- [ ] Until 22.11. Processing (Step 4.2) 
- [ ] Until 06.12. Animation (Step 4.3)
- [ ] 06.12. Exchange code in class - feedback
- [ ] 13.12. Implement feedback in class
- [ ] 20.12. Presentation of the project in class

### 6. Risks and contingency
* Is there missing data, first a data assessment needs to be done, and the impact needs to be considered. If the data isn't critical, data imputation can be considered or if that isn't an option, an alternative data source needs to be searched or the project scope needs to be adjusted. When the problem an ingredient is, then the ingredient can be changed.
* It's risky to only rely on one database for a specific type of data, as the database may can become unavailable temporary or permanent. That's why the data will be downloaded and archived at the beginning of the project.


### 7. Impact
This project can provide an insight into history, moreover in human migration, mobility and trade. And additionally, raise awareness about what we eat nowadays and where the ingredients of food originated from.


