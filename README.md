# UCB Portfolio
Portfolio of projects and work from UC Berkeley Masters of Information and Data Science degree program.

Projects included in this portfolio:

1. Lead Alert

Project lead for this capstone project using machine learning to predict lead contamination in water sources throughout the state of California. Assembly Bill 746 passed in 2017 requires lead testing at all public schools to be complete by 2019. Early returns on this data could be used as label data to create an ML model that would predict lead contamination based on community feature data. The dataset provided challenges around imbalanced data, as less than 5% of samples showed contamination. This required the use of techniques such as Synthetic Minority Oversampling Technique (SMOTE) to avoid overfitting to the minority data records. More complete information can be found at the project website, [leadalert.io](www.leadalert.io), including a technical white paper and a public repo with all code and data.

2. Yelp Dataset Challenge

Final group project from Python course and submitted to Yelp's Dataset Challenge in January 2017. The project attempts to identify underserved locations for an entrepreneur to open a business based on existing business review and location data from Yelp. Example analysis includes opening a pizza parlor in Phoenix, Arizona and Edinborough, Scotland. The analysis finds both concentration and quality of similar businesses, and identifies areas underserved by high quality establishments. It also identifies candidate locations based on recently closed or poorly rated establishments of a similar type.

3. Air Travel Dashboard

Final group project from W205 Data Storage and Retrieval. Analysis of historical flight and weather data showing airport performance under varioius conditions. Designed to be run on an AWS EC2 instance, the project pulls data from the Bureau of Transportation Statistics and the National Oceanographic and Atmospheric Administration and loads them into Hadoop. It then creates tables in Hive and exports csv files based on queries to match project metrics. The csv files are then imported by an R Markdown file to create the dashboard using R Shiny. Personal contribution includes historical weather delay analysis and delay forecast using 10 day rainfall forecast accessed via Weather Underground API for 25 busiest US airports.

4. Algorithm Explainability

This final group project was a joint project for two courses - W241 Experiments and Causality, and W231 Behind the Data: Humans and Values. The project was based on the idea of a right to an explanation of algorithmic decisions as included in the GDPR. We attempted to answer teh research question "Do certain kinds of explanations of algorithmic decisions inspire different levels of trust and acceptance in their decisions?" To answer this, we solicited over 600 respondents from Mechanical Turk and directed them to a Qualtrics survey of our design. Our results found that a good explanation can indeed increase trust and acceptance of algorithmic descisions in a statistically significantly way. The files contained in this folder include the final report in a PDF format, the R Markdown file including all analysis, and the survey data exported from Qualtrics as a csv which was imported directly to the R Markdown file.

5. United Nations Sustainable Development Goals Viewer

Final group project for W209 Data Visualization. In the year 2000, all 191 member states of the United Nations adopted the United Nations Millennium Declaration, an agreement to improve various metrics of quality of life around the world by 2015. These metrics included such ideals as the eradication of extreme poverty and hunger, as well to ensure environmental sustainability. The Sustainable Development Goals (SDGs) are comprised of 17 goals, with 169 targets, and even more indicators to quantify progress. The SDG data can be very difficult to navigate due to the large number of countries, goals, and indicators. Our team project aims to simplify the presentation of this data and allow a user to quickly explore and understand how every country is performing on every indicator. Additionally, we have attempted to link various international aid programs with the countries and goals they are working to improve. This will enable more people to engage with efforts to address issues they care about, or to find aid programs to which they can contribute. The visualization was created from several Tableau dashboards. The link below serves as an “about” page or landing page for the project. It contains more information on each of the pages of the visualization.  

https://msannat.github.io/W209/

6. Zillow Challenge

Final group project for W207 Machine Learning. The included pdf file is the team's final presentation. The Zillow Prize was a Kaggle competition using various machine learning algorithms to predict Zillow’s price estimate error rate for every home in 3 Southern California counties. The prediction had to be based on house feature data available from assessor data and the MLS database. Our team tried several machine learning techniques, ultimately finding the best performance with boosted regression using XGBoost. Feature creation proved to be useful as well, including personal contribution of geographical analysis showing neighborhood effects on error rates.

7. Water Balance

Individual midterm project from Python course. Python scripts allow user to calculate water demands for a development project with user-specified development program. Also pulls relevant precipitation and evapotranspiration data from online sources based on a user-specified US zip code.
