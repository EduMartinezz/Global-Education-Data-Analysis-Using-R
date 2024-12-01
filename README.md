# Global-Education-Data-Analysis-Using-R
## **Project Description**
Access to quality education is one of the most significant indicators of a nation's progress. The **Global Education Data Analysis** project explores the intricate relationships between education, socioeconomic factors, and global disparities. This project investigates the impact of literacy rates, enrollment patterns, gender disparities, and educational proficiency across countries. The aim is to understand global education dynamics and contribute to building a data-driven foundation for policymaking, advocacy, and awareness.

## Dataset Overview
__Source__
- Dataset Name: Global Education Data
- File: global_education_data.csv
- Format: CSV
- Source: Kaggle
  
__Key Features__
1. __Countries and Areas:__ Names of countries or regions.

2. __Enrollment Rates:__
- Gross Primary Education Enrollment
- Gross Tertiary Education Enrollment

3. **Proficiency Levels:**
- Primary End Proficiency 
- Lower and Upper Secondary End Proficiency

4. __Literacy Rates:__
- Youth Literacy Rates (Male and Female)
- Adult Literacy Rates (if applicable)

5. **Education Completion Rates:**
- Primary, Lower Secondary, and Upper Secondary (Male and Female)

6. **Out-of-School Rates:**
- Rates for Primary, Lower Secondary, and Upper Secondary (Male and Female)

7. **Socioeconomic Indicators:**
- Unemployment Rate
- Birth Rate

8.**Geographic Details:**
- Latitude and Longitude

# **Project Objectives**
1. Examine global literacy disparities by gender.
2. Analyze the relationship between educational proficiency and socioeconomic factors.
3. Understand enrollment patterns across education levels and countries.
4. Investigate the impact of unemployment and birth rates on education.
5. Create engaging visualizations to present findings effectively.

# **Analysis Workflow**
**Step 1: Data Preprocessing**
- Identify missing values and handling them appropriately.
- Conversion of variables to suitable data types for analysis.

**Step 2: Exploratory Data Analysis (EDA)**
- Generate descriptive statistics.
- Create interactive visualizations using libraries like ggplot2 and plotly.

**Step 3: Statistical Analysis**
- Perform correlation and regression analyses.
- Use ANOVA to compare group means where applicable.

**Step 4: Visualization**
- Develop insightful plots, such as histograms, scatterplots, heatmaps, and treemaps.

**Step 5: Reporting**
- Summarize findings and create actionable insights for stakeholders.

Key Findings
**1. Gender Literacy Disparities:**
- Male literacy rates are slightly higher than female rates in most regions.
- The literacy gap is prominent in developing countries.

**2. Proficiency Trends:**
- High proficiency rates in reading and math are observed in developed countries.
- Developing regions show a significant proficiency gap.

**3. Impact of Socioeconomic Factors:**
- Countries with higher unemployment rates tend to have lower literacy and enrollment rates.
- High birth rates are negatively correlated with education outcomes.

**4. Remote Work Trends:**
- Countries with higher tertiary enrollment also exhibit higher unemployment rates, indicating 
  skills mismatches.

## **Visualizations and Insights**
**Examples of Key Visualizations:**
1. **Heatmap of Education Indicators:**
- Displays global trends across key education metrics.

2. **Literacy Rates by Gender:**
- Highlights disparities between male and female literacy rates.

3. **Treemap of Enrollment Rates:**
- Compares gross enrollment rates across countries.

4. **Impact of Unemployment on Education:**
- Correlation plot showcasing the relationship between unemployment rates and literacy levels.

## **Setup and Dependencies**
**Required Libraries**
Install the following R libraries:
install.packages(c("tidyverse", "ggplot2", "plotly", "treemapify", "wordcloud"))

### Instructions for Reproducing the Analysis
1. Clone this repository:

``git clone https://github.com/username/Global-Education-Data-Analysis.git

2. Open the R scripts in the Scripts folder.

3. Install the required libraries listed above.

4. Run the scripts in the provided order.

## OR

__File Setup__
- Download the dataset global_education_data.csv.
- Place it in the appropriate directory.

**Running the Analysis**
1. Load the global_education_data.csv file:
`` data_edu <- read.csv("path/to/global_education_data.csv")

2. Execute the scripts in the provided order.

## Folder Structure
📂 Global-Education-Data-Analysis
├── 📁 Data
│   └── global_education_data.csv
├── 📁 Scripts
│   └── analysis.R
├── 📁 Visualizations
│   ├── literacy_disparities.png
│   ├── heatmap_indicators.png
│   ├── enrollment_treemap.png
│   └── unemployment_correlation.png
├── 📁 Reports
│   └── findings.pdf
├── README.md


**Recommendations**
__Policymakers:__
- Address gender disparities in education through targeted programs.
- Focus on improving primary and tertiary enrollment in low-performing regions.

__NGOs and Stakeholders:__
- Promote literacy campaigns in regions with significant gender gaps.
- Bridge the skills gap between education and employment.

__Educators:__
- Adapt curricula to enhance proficiency in reading and math.

**Future Enhancements**
- Integrate additional socioeconomic indicators for deeper insights.
- Develop an interactive dashboard using Shiny for real-time data exploration.
- Apply machine learning models to predict future trends in education.


