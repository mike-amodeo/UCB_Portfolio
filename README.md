# UCB Portfolio
Portfolio of projects and work from UC Berkeley Masters of Information and Data Science degree program.

Projects included in this portfolio:

1. Water Balance

Individual midterm project from Python course. Python scripts allow user to calculate water demands for a development project with user-specified development program. Also pulls relevant precipitation and evapotranspiration data from online sources based on a user-specified US zip code.

2. Yelp Dataset Challenge

Final group project from Python course and submitted to Yelp's Dataset Challenge in January 2017. The project attempts to identify underserved locations for an entrepreneur to open a business based on existing business review and location data from Yelp. Example analysis includes opening a pizza parlor in Phoenix, Arizona and Edinborough, Scotland. The analysis finds both concentration and quality of similar businesses, and identifies areas underserved by high quality establishments. It also identifies candidate locations based on recently closed or poorly rated establishments of a similar type. 

3. Air Travel Dashboard

Final group project from W205 Data Storage and Retrieval. Analysis of historical flight and weather data showing airport performance under varioius conditions. Designed to be run on an AWS EC2 instance, the project pulls data from the Bureau of Transportation Statistics and the National Oceanographic and Atmospheric Administration and loads them into Hadoop. It then creates tables in Hive and exports csv files based on queries to match project metrics. The csv files are then imported by an R Markdown file to create the dashboard using R Shiny. Personal contribution includes historical weather delay analysis and delay forecast using 10 day rainfall forecast accessed via Weather Underground API for 25 busiest US airports.
