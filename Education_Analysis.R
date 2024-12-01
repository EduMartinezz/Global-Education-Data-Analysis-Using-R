#Load Required Libraries
# Install and load necessary libraries
libraries <- c("tidyverse", "ggrepel", "treemap", "treemapify", "plotly", "viridis", "reshape2")
missing_libraries <- libraries[!libraries %in% installed.packages()[,"Package"]]
if(length(missing_libraries)) install.packages(missing_libraries, dependencies = TRUE)

# Load Libraries
library(tidyverse)
library(ggrepel)
library(treemap)
library(treemapify)
library(plotly)
library(viridis)
library(reshape2)



# Load and Clean the Dataset
# Load the dataset
data_edu <- read.csv("C:\\Users\\User\\Downloads\\global_education_data.csv")
data_edu

# Data overview
missing_values <- colSums(is.na(data_edu))
cat("Missing Values:\n")
print(missing_values)
summary(data_edu)

# Function to convert specific columns to numeric
convert_to_numeric <- function(df, columns) {
  df[columns] <- lapply(df[columns], as.numeric)
  return(df)
}

#Distribution of Birth Rates
ggplot(data_edu, aes(x = Birth_Rate)) +
  geom_histogram(binwidth = 2, fill = "#69b3a2", color = "black", alpha = 0.7) +
  labs(
    title = "Distribution of Birth Rates Across Countries",
    x = "Birth Rate (Per 1,000 People)",
    y = "Number of Countries"
  ) +
  theme_minimal()



# Adding a Region column to the dataset
data_edu <- data_edu %>%
  mutate(Region = case_when(
    Countries.and.areas %in% c("Nigeria", "Kenya", "South Africa") ~ "Africa",
    Countries.and.areas %in% c("India", "China", "Japan") ~ "Asia",
    Countries.and.areas %in% c("USA", "Canada", "Mexico") ~ "North America",
    Countries.and.areas %in% c("Germany", "France", "UK") ~ "Europe",
    TRUE ~ "Other"  # Default group for remaining countries
  ))

# Select top 5 countries by Birth Rate in each Region
top_countries <- data_edu %>%
  group_by(Region) %>%
  arrange(desc(Birth_Rate)) %>%
  slice_head(n = 5)

# Calculate regional averages for dashed lines
regional_averages <- top_countries %>%
  group_by(Region) %>%
  summarise(Average = mean(Birth_Rate, na.rm = TRUE))

# Plot the top 5 countries by birth rate
ggplot(top_countries, aes(x = reorder(Countries.and.areas, -Birth_Rate), y = Birth_Rate, fill = Region)) +
  geom_bar(stat = "identity", color = "black", show.legend = FALSE) +
  facet_wrap(~ Region, scales = "free") +
  geom_hline(data = regional_averages, aes(yintercept = Average), color = "red", linetype = "dashed", size = 0.8) +
  labs(
    title = "Top 5 Countries by Birth Rate in Each Region",
    x = "Country",
    y = "Birth Rate (per 1,000 people)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    strip.text = element_text(size = 12, face = "bold")
  )

# Create the treemap
treemap(
  top_countries,
  index = c("Region", "Countries.and.areas"),
  vSize = "Birth_Rate",
  vColor = "Region",
  palette = "Set2",
  title = "Birth Rates by Region and Country",
  fontsize.labels = c(15, 12),
  fontsize.title = 20
)

ggplot(top_countries, aes(x = reorder(Countries.and.areas, -Birth_Rate), y = Birth_Rate, fill = Region)) +
  geom_bar(stat = "identity", color = "black", show.legend = FALSE) +
  facet_wrap(~ Region, scales = "free") +
  geom_hline(data = top_countries %>% group_by(Region) %>% summarise(Average = mean(Birth_Rate)), 
             aes(yintercept = Average), color = "red", linetype = "dashed", size = 0.8) +
  labs(
    title = "Top 5 Countries by Birth Rate in Each Region",
    x = "Country",
    y = "Birth Rate (per 1,000 people)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    strip.text = element_text(size = 12, face = "bold")
  )


treemap(top_countries,
        index = c("Region", "Countries.and.areas"),
        vSize = "Birth_Rate",
        vColor = "Region",
        palette = "Set2",
        title = "Birth Rates by Region and Country",
        fontsize.labels = c(15, 12),
        fontsize.title = 20)


#Top 10 Countries Analysis
# Top 10 countries by birth rate
data_edu <- convert_to_numeric(data_edu, c("Birth_Rate"))
top_10_birth_rate <- data_edu %>%
  arrange(desc(Birth_Rate)) %>%
  slice_head(n = 10)

ggplot(top_10_birth_rate, aes(x = reorder(Countries.and.areas, -Birth_Rate), y = Birth_Rate, fill = Countries.and.areas)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_viridis_d() +
  geom_text(aes(label = round(Birth_Rate, 2)), vjust = -0.5) +
  labs(title = "Top 10 Countries with Highest Birth Rates",
       subtitle = "Analysis of Global Birth Rates",
       x = "Countries", y = "Birth Rate (Per 1,000 People)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

# Top 10 countries with lowest birth rates
top_10_birth_rate_low <- data_edu %>%
  filter(Birth_Rate > 0) %>%
  arrange(Birth_Rate) %>%
  slice_head(n = 10)

ggplot(top_10_birth_rate_low, aes(x = reorder(Countries.and.areas, Birth_Rate), y = Birth_Rate, fill = Countries.and.areas)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_viridis_d(option = "plasma") +
  geom_text(aes(label = round(Birth_Rate, 2)), vjust = -0.5) +
  labs(title = "Top 10 Countries with Lowest Birth Rates",
       subtitle = "Analysis of Global Birth Rates",
       x = "Countries", y = "Birth Rate (Per 1,000 People)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")



# --- Top 10 Countries by Unemployment Rate ---
data_edu <- convert_to_numeric(data_edu, c("Unemployment_Rate"))
top_10_unemployment <- data_edu %>%
  arrange(desc(Unemployment_Rate)) %>%
  slice_head(n = 10)

ggplot(top_10_unemployment, aes(x = reorder(Countries.and.areas, -Unemployment_Rate), y = Unemployment_Rate, fill = Countries.and.areas)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_brewer(palette = "Set3") +
  geom_text(aes(label = round(Unemployment_Rate, 2)), vjust = -0.5) +
  labs(title = "Top 10 Countries with Highest Unemployment Rates",
       subtitle = "Analysis of Global Unemployment Rates",
       x = "Countries", y = "Unemployment Rate (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")


# --- Out-of-School Rate by Gender ---
data_edu <- convert_to_numeric(data_edu, c("OOSR_Pre0Primary_Age_Male", "OOSR_Pre0Primary_Age_Female"))
average_oosr <- data_edu %>%
  summarise(
    Avg_Male = mean(OOSR_Pre0Primary_Age_Male, na.rm = TRUE),
    Avg_Female = mean(OOSR_Pre0Primary_Age_Female, na.rm = TRUE)
  )

oosr_diff <- data.frame(
  Gender = c("Male", "Female"),
  Rate = c(average_oosr$Avg_Male, average_oosr$Avg_Female)
)


#Gender-Based Analysis

# Transform literacy rates for analysis
literacy_long <- data_edu %>%
  select(Countries.and.areas, Youth_15_24_Literacy_Rate_Male, Youth_15_24_Literacy_Rate_Female) %>%
  pivot_longer(cols = starts_with("Youth"), names_to = "Gender", values_to = "Literacy_Rate") %>%
  mutate(Gender = gsub("Youth_15_24_Literacy_Rate_", "", Gender))

# Boxplot for male vs. female literacy rates

# Calculate summary statistics for literacy rates
literacy_summary <- literacy_long %>%
  group_by(Gender) %>%
  summarise(
    Avg_Literacy_Rate = mean(Literacy_Rate, na.rm = TRUE),
    SD_Literacy_Rate = sd(Literacy_Rate, na.rm = TRUE)
  )

# Bar plot with error bars and values on top
ggplot(literacy_summary, aes(x = Gender, y = Avg_Literacy_Rate, fill = Gender)) +
  geom_bar(stat = "identity", color = "black", width = 0.6) +
  geom_errorbar(aes(ymin = Avg_Literacy_Rate - SD_Literacy_Rate, 
                    ymax = Avg_Literacy_Rate + SD_Literacy_Rate), 
                width = 0.2, color = "black") +
  geom_text(aes(label = round(Avg_Literacy_Rate, 1)), vjust = -0.5, size = 5) +
  scale_fill_manual(values = c("#4CAF50", "#1976D2")) +
  labs(
    title = "Comparison of Male and Female Literacy Rates",
    subtitle = "Average Literacy Rates with Standard Deviation",
    x = "Gender",
    y = "Average Literacy Rate (%)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12),
    legend.position = "none"
  )


# Calculate literacy gaps
data_edu <- data_edu %>%
  mutate(Literacy_Gap = Youth_15_24_Literacy_Rate_Male - Youth_15_24_Literacy_Rate_Female)

largest_gaps <- data_edu %>%
  arrange(desc(abs(Literacy_Gap))) %>%
  slice_head(n = 10)

# Plot literacy gaps
ggplot(largest_gaps, aes(x = reorder(Countries.and.areas, -abs(Literacy_Gap)), y = Literacy_Gap, fill = Literacy_Gap > 0)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  scale_fill_manual(values = c("#e31a1c", "#1f78b4")) +
  labs(title = "Top 10 Countries with Largest Literacy Gaps by Gender",
       x = "Countries", y = "Literacy Gap (Male - Female)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Out-of-School Rate by Gender
ggplot(oosr_diff, aes(x = "", y = Rate, fill = Gender)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  labs(
    title = "Out-of-School Rate by Gender",
    subtitle = "Global Analysis of Education Disparities",
    fill = "Gender"
  ) +
  theme_void() +
  geom_text(aes(label = paste0(round(Rate, 2), "%")), position = position_stack(vjust = 0.5), size = 5, color = "white") +
  scale_fill_manual(values = c("#0073C2FF", "#EFC000FF")) +
  annotate("text", x = 0, y = 0, label = "100%", size = 8, fontface = "bold", color = "black")

# Out-of-School Rate by Gender(Interactive Version)
region_data <- data_edu %>% filter(Region == "Africa")
library(plotly)
plot_ly(oosr_diff, labels = ~Gender, values = ~Rate, type = 'pie',
        textinfo = 'label+percent', insidetextorientation = 'radial') %>%
  layout(title = "Out-of-School Rate by Gender: Interactive Version")


# --- Reading Proficiency Analysis ---
data_edu <- convert_to_numeric(data_edu, c("Primary_End_Proficiency_Reading"))

# Top 10 Countries with Highest Reading Proficiency
top_10_reading <- data_edu %>%
  arrange(desc(Primary_End_Proficiency_Reading)) %>%
  slice_head(n = 10)

ggplot(top_10_reading, aes(x = reorder(Countries.and.areas, -Primary_End_Proficiency_Reading), y = Primary_End_Proficiency_Reading, fill = Countries.and.areas)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_viridis_d(option = "magma") +
  geom_text(aes(label = round(Primary_End_Proficiency_Reading, 2)), vjust = -0.5) +
  labs(
    title = "Top 10 Countries by Reading Proficiency",
    subtitle = "Proficiency at End of Primary School",
    x = "Countries",
    y = "Reading Proficiency (%)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")


#Heatmap of Education Indicators
# Calculate average indicator value and filter top 20 countries
top_countries <- data_edu %>%
  select(Countries.and.areas, all_of(education_vars)) %>%
  rowwise() %>%
  mutate(Average_Value = mean(c_across(-Countries.and.areas), na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(Average_Value)) %>%
  slice_head(n = 20) %>%
  pivot_longer(cols = education_vars, names_to = "Indicator", values_to = "Value")

# Heatmap for top 20 countries
ggplot(top_countries, aes(x = reorder(Countries.and.areas, Average_Value), y = Indicator, fill = Value)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "plasma", name = "Value", direction = -1) +
  labs(
    title = "Heatmap of Education Indicators (Top 20 Countries)",
    subtitle = "Based on Average Indicator Value",
    x = "Countries",
    y = "Education Indicators"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 8),  # Rotate x-axis labels
    axis.text.y = element_text(size = 10),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )


#Facet the Heatmap by Indicator
ggplot(top_countries, aes(x = reorder(Countries.and.areas, Average_Value), y = Indicator, fill = Value)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "plasma", name = "Value", direction = -1) +
  labs(
    title = "Heatmap of Education Indicators (Top 20 Countries)",
    subtitle = "Faceted View by Indicator",
    x = "Countries",
    y = "Education Indicators"
  ) +
  facet_wrap(~ Indicator, scales = "free_y") +  # Facet by Indicator
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 8),
    axis.text.y = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )


# Shorten indicator names for better display
education_heatmap$Indicator <- str_replace_all(education_heatmap$Indicator, "_", " ")

ggplot(top_countries, aes(x = reorder(Countries.and.areas, Average_Value), y = Indicator, fill = Value)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "magma", name = "Value", direction = -1) +
  labs(
    title = "Heatmap of Education Indicators (Top 20 Countries)",
    subtitle = "Improved Labeling for Clarity",
    x = "Countries",
    y = "Education Indicators"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    axis.text.y = element_text(size = 10),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )



# --- Relationship: Literacy Rates (15-24 Years) by Gender ---
data_edu <- convert_to_numeric(data_edu, c("Youth_15_24_Literacy_Rate_Male", "Youth_15_24_Literacy_Rate_Female"))


ggplot(data_edu, aes(x = Youth_15_24_Literacy_Rate_Male, y = Youth_15_24_Literacy_Rate_Female, label = Countries.and.areas)) +
  geom_point(color = "#6A5ACD") +
  geom_text_repel(box.padding = 0.3) +
  labs(
    title = "Literacy Rates by Gender (15-24 Years)",
    subtitle = "Exploring Disparities Between Male and Female Youth",
    x = "Male Literacy Rate (%)",
    y = "Female Literacy Rate (%)"
  ) +
  theme_minimal() +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red")



#basic statistics for male and female literacy rates
literacy_summary <- data_edu %>%
  summarise(
    Avg_Literacy_Male = mean(Youth_15_24_Literacy_Rate_Male, na.rm = TRUE),
    Avg_Literacy_Female = mean(Youth_15_24_Literacy_Rate_Female, na.rm = TRUE),
    Median_Literacy_Male = median(Youth_15_24_Literacy_Rate_Male, na.rm = TRUE),
    Median_Literacy_Female = median(Youth_15_24_Literacy_Rate_Female, na.rm = TRUE)
  )
print(literacy_summary)




#Distribution of Literacy Rates
literacy_long <- data_edu %>%
  select(Countries.and.areas, Youth_15_24_Literacy_Rate_Male, Youth_15_24_Literacy_Rate_Female) %>%
  pivot_longer(cols = starts_with("Youth"), names_to = "Gender", values_to = "Literacy_Rate")

ggplot(literacy_long, aes(x = Literacy_Rate, fill = Gender)) +
  geom_density(alpha = 0.7) +
  scale_fill_manual(values = c("#1f78b4", "#e31a1c")) +
  labs(
    title = "Distribution of Literacy Rates by Gender",
    x = "Literacy Rate (%)",
    y = "Density",
    fill = "Gender"
  ) +
  theme_minimal()

#Countries with Largest Literacy Gaps
data_edu <- data_edu %>%
  mutate(Literacy_Gap = Youth_15_24_Literacy_Rate_Male - Youth_15_24_Literacy_Rate_Female)

largest_gaps <- data_edu %>%
  arrange(desc(abs(Literacy_Gap))) %>%
  slice_head(n = 10)

ggplot(largest_gaps, aes(x = reorder(Countries.and.areas, -abs(Literacy_Gap)), y = Literacy_Gap, fill = Literacy_Gap > 0)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  scale_fill_manual(values = c("#e31a1c", "#1f78b4")) +
  labs(
    title = "Top 10 Countries with Largest Literacy Gaps by Gender",
    x = "Countries",
    y = "Literacy Gap (Male - Female)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Correlation Matrix
numeric_cols <- data_edu %>%
  select(where(is.numeric)) %>%
  cor(use = "pairwise.complete.obs")

# Focus on Key Variables
selected_vars <- c("Gross_Primary_Education_Enrollment", "Unemployment_Rate", 
                   "Youth_15_24_Literacy_Rate_Male", "Youth_15_24_Literacy_Rate_Female",
                   "Completion_Rate_Primary_Male", "Completion_Rate_Primary_Female")

cor_matrix_subset <- cor(data_edu[selected_vars], use = "pairwise.complete.obs")

cor_melted_subset <- melt(cor_matrix_subset)

# Visualize Subset of Correlations
ggplot(cor_melted_subset, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 0, limit = c(-1, 1)) +
  geom_text(aes(label = round(value, 2)), size = 3) +
  labs(
    title = "Correlation Matrix of Selected Variables",
    subtitle = "Highlighting Relationships Between Education and Socioeconomic Factors",
    fill = "Correlation"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.text.y = element_text(size = 10)
  )

# Education Enrollment vs. Unemployment
ggplot(data_edu, aes(x = Gross_Tertiary_Education_Enrollment, y = Unemployment_Rate)) +
  geom_point(color = "#2c7fb8", alpha = 0.7) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(
    title = "Relationship Between Tertiary Education Enrollment and Unemployment",
    x = "Gross Tertiary Education Enrollment (%)",
    y = "Unemployment Rate (%)"
  ) +
  theme_minimal()

#Trend Analysis: Education Completion Rates
completion_long <- data_edu %>%
  select(Countries.and.areas, Completion_Rate_Primary_Male, Completion_Rate_Primary_Female) %>%
  pivot_longer(-Countries.and.areas, names_to = "Gender", values_to = "Completion Rate")

ggplot(completion_long, aes(x = Gender, y = `Completion Rate`, fill = Gender)) +
  geom_boxplot() +
  scale_fill_manual(values = c("#1f78b4", "#33a02c")) +
  labs(
    title = "Distribution of Primary Education Completion Rates",
    x = "Gender",
    y = "Completion Rate (%)"
  ) +
  theme_minimal()

#Education completion by level and gender
completion_long <- data_edu %>%
  select(
    Countries.and.areas,
    Completion_Rate_Primary_Male,
    Completion_Rate_Primary_Female,
    Completion_Rate_Lower_Secondary_Male,
    Completion_Rate_Lower_Secondary_Female,
    Completion_Rate_Upper_Secondary_Male,
    Completion_Rate_Upper_Secondary_Female
  ) %>%
  pivot_longer(
    cols = -Countries.and.areas,
    names_to = c("Education_Level", "Gender"),
    names_pattern = "Completion_Rate_(.*)_(Male|Female)",
    values_to = "Completion_Rate"
  )

# Print the transformed data to check structure
print(head(completion_long))

# Recreate the grouped bar plot with raw data points
ggplot(completion_long, aes(x = Education_Level, y = Completion_Rate, fill = Gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_point(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.9), 
             color = "black", alpha = 0.5) +
  labs(
    title = "Education Completion Rates by Level and Gender",
    x = "Education Level",
    y = "Completion Rate (%)"
  ) +
  scale_fill_manual(values = c("Male" = "#1f77b4", "Female" = "#ff7f0e")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  )

#Education Indicators
ggplot(data_edu, aes(x = Gross_Primary_Education_Enrollment)) +
  geom_boxplot(fill = "#a6cee3", color = "black") +
  labs(
    title = "Outlier Detection in Primary Education Enrollment",
    x = "Gross Primary Education Enrollment",
    y = ""
  ) +
  theme_minimal()

#Treemap of Education Metrics
install.packages('treemapify')
library(treemapify)

treemap_data <- data_edu %>%
  filter(!is.na(Birth_Rate)) %>%
  mutate(Size = Birth_Rate) %>%
  select(Countries.and.areas, Size)

ggplot(treemap_data, aes(area = Size, fill = Size, label = Countries.and.areas)) +
  geom_treemap() +
  geom_treemap_text(color = "white", place = "center") +
  scale_fill_viridis_c() +
  labs(title = "Treemap of Birth Rates by Country")


# Interactive scatterplot
plot_ly(data_edu, x = ~Gross_Primary_Education_Enrollment, y = ~Unemployment_Rate, 
        text = ~Countries.and.areas, type = 'scatter', mode = 'markers') %>%
  layout(title = "Interactive Dashboard: Education vs. Unemployment",
         xaxis = list(title = "Gross Primary Education Enrollment (%)"),
         yaxis = list(title = "Unemployment Rate (%)"))




