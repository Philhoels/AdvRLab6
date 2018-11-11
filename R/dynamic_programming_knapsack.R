#'@title Dynamic Knapsack Algorithm
#'@description Knapsack problem solution using Dynamic Algorithm in R.
#'             It calculates best values and weights for given capacity.
#'@references https://en.wikipedia.org/wiki/Knapsack_problem#0.2F1_knapsack_problem
#'@param x Dataframe with variables v and w.
#'@param W Integer as capacity.
#'@export
#'@return Returns a list with best value and combination.


#-------------------------------------- The following is pseudo code for the dynamic program:
# for j from 0 to W do:
#   m[0, j] := 0
#
# for i from 1 to n do:
#   for j from 0 to W do:
#   if w[i] > j then:
#   m[i, j] := m[i-1, j]
# else:
#     m[i, j] := max(m[i-1, j], m[i-1, j-w[i]] + v[i])
#-------------------------------------- -------------------------------------------------------

# Test ------------------------------------------------------------------------------

# Don´t use this code - create your own!!!
# It´s from Alex and just for helping to understanding the problem!!

dynamic_knapsack <- function(x,W){
  stopifnot(is.data.frame(x))
  stopifnot(c("v", "w") %in% names(x))
  stopifnot(is.numeric(x$w) && is.numeric(x$v))
  stopifnot(any(x$w <= W) || any(x$v > 0))
  stopifnot(W > 0)
  value_mat <- matrix(NA, nrow = nrow(x) + 1, ncol = W + 1)
  value_mat[1, ] <- 0
  rownames(value_mat) <- paste("i =", 0:(nrow(x)))
  colnames(value_mat) <- paste("j =", 0:(W))
  w <- x$w
  v <- x$v
  n <- nrow(x)
  for (i in 2:(n + 1)) {
    for (j in 2:(W + 2)) {
      if (w[i - 1] > j - 2) {
        value_mat[i, j - 1] = value_mat[i - 1, j - 1]
      }
      else {
        value_mat[i, j - 1] = max((value_mat[i - 1, j -
                                               1]), (value_mat[i - 1, j - 1 - w[i - 1]] +
                                                       v[i - 1]))
      }
    }
  }
  row_nr <- nrow(value_mat)
  col_nr <- ncol(value_mat)
  elements <- c()
  while (col_nr > 1 & row_nr > 1) {
    if (value_mat[row_nr, col_nr] != value_mat[row_nr - 1,
                                               col_nr]) {
      elements <- c(elements, row_nr - 1)
      col_nr <- col_nr - x$w[row_nr - 1]
    }
    row_nr <- row_nr - 1
  }
  return(list(value = round(value_mat[nrow(value_mat), ncol(value_mat)]),
              elements = sort(elements)))

}

# dynamic_knapsack(x = knapsack_objects[1:8,], W = 3500)
# dynamic_knapsack(x = knapsack_objects[1:12,], W = 3500)
# dynamic_knapsack(x = knapsack_objects[1:8,], W = 2000)
# dynamic_knapsack(x = knapsack_objects[1:12,], W = 2000)

#system.time(dynamic_knapsack(x = knapsack_objects[1:8,], W = 3500))
