
# model_training.R - Functions for model training, evaluation, and prediction

library(caret)
library(randomForest)

# Function to train a machine learning model
train_model <- function(data) {
  # Split data into training and testing sets
  set.seed(123)
  train_index <- createDataPartition(data$Target, p = 0.8, list = FALSE)
  train_data <- data[train_index, ]
  test_data <- data[-train_index, ]
  
  # Train a Random Forest model
  model <- randomForest(as.factor(Target) ~ Feature1_scaled + Feature2_scaled, data = train_data, ntree = 100)
  return(model)
}

# Function to evaluate the model
evaluate_model <- function(model, data) {
  # Predict on the test data
  predictions <- predict(model, newdata = data)
  
  # Create a confusion matrix
  confusion_matrix <- confusionMatrix(predictions, as.factor(data$Target))
  return(confusion_matrix)
}

# Function to make predictions on new data
predict_model <- function(model, new_data) {
  # Ensure new_data has the same scaled features as training data
  # For simplicity, assuming scaling parameters are known or applied externally
  new_data$Feature1_scaled <- (new_data$Feature1 - min(new_data$Feature1)) / (max(new_data$Feature1) - min(new_data$Feature1))
  new_data$Feature2_scaled <- (new_data$Feature2 - min(new_data$Feature2)) / (max(new_data$Feature2) - min(new_data$Feature2))
  
  predictions <- predict(model, newdata = new_data)
  return(predictions)
}
