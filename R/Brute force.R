#'@title Brute Force Knapsack Algorithm
#'@description Knapsack problem solution using Brute Force Algorithm in R.
#'             It calculates best values and weights for given capacity.
#'@param x Dataframe with variables v and w.
#'@param W Integer as capacity.
#'@param parallel Boolean makes function parallel
#'@importFrom utils combn
#'@export
#'@return Returns a list with best value and combination.


brute_force_knapsack <- function(x,W){

  Combinations <- list() #creating a list of combnations
  for(i in 1:nrow(x)){
    Combinations[[i]] <- combn(rownames(x), i, paste, collapse = " ")
  }

  Weights <- list() # creating a list of weights
  for(i in 1:nrow(x)){
    Weights[[i]] <- combn(x$w, i,sum)
  }

  Values <- list() # creating a list of values
  for(i in 1:nrow(x)){
    Values[[i]] <- combn(x$v, i,sum)
  }

  Combinations_vector <- unlist(Combinations) # creating vectors by unlisting
  Weights_vector <- unlist(Weights)
  Values_vector <- round(unlist(Values))

  Capacity_weight <- which(Weights_vector < W) #using which to get the indexes of weight
  validValues <- Values_vector[Capacity_weight]
  maxValue <- max(validValues)

  Value_Combinations <- which(Values_vector == maxValue) # using which to get the maximum Value
  validCombination <- Combinations_vector[Value_Combinations]

  best_combination <- list(value = maxValue, elements = validCombination) #creating a list
  return(best_combination)
}


# brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
# brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500)
# brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
# brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000)
