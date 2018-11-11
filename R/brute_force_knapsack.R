#'@title Dynamic Knapsack Algorithm
#'@description Knapsack problem solution using Dynamic Algorithm in R.
#'             It calculates best values and weights for given capacity.
#'@references https://en.wikipedia.org/wiki/Knapsack_problem#0.2F1_knapsack_problem
#'@param x Dataframe with variables v and w.
#'@param W Integer as capacity.
#'@export
#'@return Returns a list with best value and combination.

library(parallel)

# try pararllel with big data to check !!!!!!!!!!!!!!!!!!!

brute_force_knapsack <- function(x,W, parallel = TRUE){

  if(!is.data.frame(x) || W < 1){
    stop("functions rejects errounous input")
  }
  if(parallel == FALSE){
    Combinations <- list() #creating a list of combnations
    for(i in 1:nrow(x)){
      Combinations[[i]] <- combn(rownames(x), i, paste, collapse = "")
    }

    Weights <- list() # creating a list of weights
    for(i in 1:nrow(x)){
      Weights[[i]] <- combn(x$w, i,sum)
    }

    Values <- list() # creating a list of values
    for(i in 1:nrow(x)){
      Values[[i]] <- combn(x$v, i, sum)
    }

    Combinations_vector <- unlist(Combinations) # creating vectors by unlisting
    Weights_vector <- unlist(Weights)
    Values_vector <- round(unlist(Values),0)

    Capacity_weight <- which(Weights_vector < W) #using which to get the indexes of weight
    validValues <- Values_vector[Capacity_weight]
    maxValue <- max(validValues)

    Value_Combinations <- which(Values_vector == maxValue) # using which to get the maximum Value
    validCombination <- as.numeric(unlist(strsplit(Combinations_vector[Value_Combinations],"")))

<<<<<<< HEAD
    best_combination <- list(value = maxValue, elements = validCombination) #creating a list
=======
  best_combination <- list(value = maxValue, elements = validCombination) #creating a list
>>>>>>> cb7797462d7f928a2e53edff5094f3d4ecc9ece7
  }
  else{
    cores <- parallel::detectCores() - 1  #check the number of cores on the computer
    cluster <- makeCluster(cores) #to set up the cluster
    clusterExport(cluster, c("x"), envir = environment())

    Combinations <- parLapplyLB(cluster, 1:nrow(x), fun =  function(y) {
      combn(rownames(x) , y , paste, collapse = "")
    })
    Weights <- parLapplyLB(cluster, 1:nrow(x), fun =  function(y) {
      combn(x$w , y, sum)
    })
    Values <- parLapplyLB(cluster,1:nrow(x), fun =  function(y) {
      combn(x$v , y , sum)

    })
    stopCluster(cluster) #to shutdown cluster
    Combinations_vector <- unlist(Combinations) # creating vectors by unlisting
    Weights_vector <- unlist(Weights)
    Values_vector <- round(unlist(Values))

    Capacity_weight <- which(Weights_vector < W) #using which to get the indexes of weight
    validValues <- Values_vector[Capacity_weight]
    maxValue <- max(validValues)

    Value_Combinations <- which(Values_vector == maxValue) # using which to get the maximum Value
    validCombination <- as.numeric(unlist(strsplit(Combinations_vector[Value_Combinations],"")))

    best_combination <- list(value = maxValue, elements = validCombination) #creating a list
<<<<<<< HEAD
  }
  return(best_combination)
=======
    }
    return(best_combination)
>>>>>>> cb7797462d7f928a2e53edff5094f3d4ecc9ece7
}


# brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
# brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500)
# brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
# brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000)

# brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500, parallel = TRUE)

# system.time(brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500))
# system.time(brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500, parallel = TRUE))
