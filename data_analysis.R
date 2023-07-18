
# data_analysis.R - Functions for data loading and preprocessing

library(dplyr)
library(tidyr)

# Function to load data from a CSV file
load_data <- function(file_path) {
  if (!file.exists(file_path)) {
    cat("Warning: Data file not found at ", file_path, ". Generating dummy data.
")
    # Generate dummy data if file not found
    set.seed(123)
    data <- data.frame(
      Feature1 = rnorm(100, mean = 10, sd = 2),
      Feature2 = runif(100, min = 0, max = 100),
      Target = sample(c(0, 1), 100, replace = TRUE)
    )
    write.csv(data, file_path, row.names = FALSE)
  }
  read.csv(file_path)
}

# Function to preprocess data
preprocess_data <- function(data) {
  # Handle missing values (example: replace with mean)
  data$Feature1[is.na(data$Feature1)] <- mean(data$Feature1, na.rm = TRUE)
  data$Feature2[is.na(data$Feature2)] <- mean(data$Feature2, na.rm = TRUE)
  
  # Feature scaling (example: min-max scaling)
  data$Feature1_scaled <- (data$Feature1 - min(data$Feature1)) / (max(data$Feature1) - min(data$Feature1))
  data$Feature2_scaled <- (data$Feature2 - min(data$Feature2)) / (max(data$Feature2) - min(data$Feature2))
  
  # Select relevant features and target
  preprocessed_data <- data %>% select(Feature1_scaled, Feature2_scaled, Target)
  return(preprocessed_data)
}
