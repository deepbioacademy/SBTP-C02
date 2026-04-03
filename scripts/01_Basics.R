# R as calculator 
5 - 2
2 + 3 
3/2

# Getting help 
# 1. Get help of a particular function using "?"
?mean

# 2. Get help of a particular concept using `help` function
help(str)

# Install R Packages 
# 1. CRAN Packages 
install.packages("package_name")
install.packages("tidyverse")

# 2. Packages for Bioinformatics (Biconductor)
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.22")

BiocManager::install("package_name")
BiocManager::install("DESeq2")

# 3. Package Management using `pak`
# Install pak 
install.packages("pak")

# Install Single CRAN Package 
pak::pkg_install("package_name")
pak::pkg_install("tidyverse")

# Install Multiple CRAN Packages 
pak::pkg_install(c("pak1", "pak2", "pak3"))
pak::pkg_install(c("tidyverse", "dplyr", "ggpubr"))

# Install Single Bioconductor Package 
pak::pkg_install("package_name")
pak::pkg_install("DESeq2")

# Install Multiple Bioconductor Packages 
pak::pkg_install(C("pak1", "pak2", "pak3"))
pak::pkg_install(c("TCGAbiolinks", "maftools", "DESeq2"))

# Variables 
# 1. name should be meaningful 
# 2. use underscore for more than one words (student_height)
a <- 10
age <- 10
my_age <- 30


# Data types 
# Numbers 
# 1. number of students > count (discrete)
num_students <- 30 
class(num_students)

# 2. height of a student > measurement (continuous)
student_height <- 5.1 
class(student_height)

# Text/Character 
# Facebook Post (Sentiment = Negative/Positive)
# Comment #1: Stupid 
# Comment #2: This is great. 
# Comment #3: Good one! 

name <- "Jubayer"
class(name)