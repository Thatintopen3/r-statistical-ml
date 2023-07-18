
# requirements.R - Script to install and load necessary R packages

install_and_load <- function(package) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

install_and_load("dplyr")
install_and_load("tidyr")
install_and_load("caret")
install_and_load("randomForest")

cat("All required R packages loaded.
")
