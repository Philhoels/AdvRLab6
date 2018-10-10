#' knapsack_objects
#'
#' A sample dataset for the knapsack problem. Code take from lab 6 of AdvR course.
#'
#' @format A data frame with 2000 rows and 2 variables:
#' \describe{
#'   \item{w}{the weight}
#'   \item{v}{the value}
#' }
"knapsack_objects"

set.seed(42)
n <- 2000
knapsack_objects <-data.frame(
  w=sample(1:4000, size = n, replace = TRUE),
  v=runif(n = n, 0, 10000)
)
