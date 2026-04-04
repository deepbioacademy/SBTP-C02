# Data Structures in R 
# 1. Vector - one dimensional data structure in R 
# Creating vector using `c()` function: combination of things / items 
vector_one <- c(2, 4, 6)
vector_one

# Create a vector using colon operator (:)
# Sequence of integers 
vector_two <- 1:10
vector_two

# Create a vector using `seq()` function 
vector_three <- seq(1, 20, 2)
vector_three

# Create a vector using `rep()` function
rep(4, times=3)

# Selecting vector elements 
x <- c(2, 4, 6, 10, 23, 45)

# By position 
# Select the fourth element 
x[4] 

# Select vector element using : 
x[1:3]

# Select specific elements 
x[c(1, 3, 5)]


# Matrix - two dimensional data structure in R 
m <- matrix(1:9)
m <- matrix(1:9, ncol = 3)
m <- matrix(1:9, ncol = 3, nrow = 3)
m 

# Properties 
dim(m)
ncol(m)
nrow(m)

# Indexing 
# Select a row
m[2, ]

# Select a column 
m[, 1]

# Select an element 
m[2, 3]

# Comparison (TRUE / FALSE)
a <- 5 
b <- 3

# equality 
a == b 

# greater 
a > b 

# less 
a < b 

# greater OR equal (a > b OR a == b)
a >= b 

# less OR equal (a < b OR a == b)
a <= b 

# not equal 
a != b 

# Decision Making 
# if statement 
if (condition) {
  # do something - decision making block 
}

x <- 10 
if (x > 0) {
  print("positive")
}

# if...else statement 
if (condition) {
  # do something 
} else {
  # do something 
}

x <- -10 
if (x > 0) {
  print("positive")
} else {
  print("negative")
} 

# ifelse() function 
ifelse(condition, "?", "?")

ages <- c(20, 16, 12, 13, 15, 22, 20)
ifelse(ages < 18, "child", "adult")

# Iteration / Loops 
print("Bangladesh")
print("Bangladesh")
print("Bangladesh")
print("Bangladesh")
print("Bangladesh")

# for loop
for (var in sequence) {
  # do something 
}

for (i in 1:5) {
  print("Bangladesh")
}

for (i in 1:5) {
  print(i)
}


# while loop 
while(condition) {
  # do something 
}

i = 1 
while(i <= 10) {
  print(i)
  i <- i + 1
}














