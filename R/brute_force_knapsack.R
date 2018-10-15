#'@title Brute Force Knapsack Algorithm
#'@description Knapsack problem solution using Brute Force Algorithm in R.
#'             It calculates best values and weights for given capacity.
#'@param x Dataframe with variables v and w.
#'@param W Integer as capacity.
#'@param parallel Boolean makes function parallel
#'@import lineprof parallel
#'@importFrom utils combn
#'@export
#'@return Returns a list with best value and combination.

library(parallel)

set.seed(42)
n <- 2000
knapsack_objects <-data.frame(
  w=sample(1:4000, size = n, replace = TRUE),
  v=runif(n = n, 0, 10000)
)


brute_force_knapsack <- function(x,W, parallel = TRUE){

  if(!is.data.frame(x) || W < 1){
    stop("The argument W needs to be positive")
  }
  if(parallel == FALSE){
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
  }
   else{
   cores <- parallel::detectCores()  #check the number of cores on the computer
   cluster <- makeCluster(cores, type = "PSOCK") #to set up the cluster
   clusterExport(cluster, c("x"), envir = environment())

    Combinations <- parLapplyLB(cluster, 1:nrow(x), fun =  function(y) {
                    combn(rownames(x) , y , paste, collapse = " ")
    })
    Weights <- parLapplyLB(cluster, 1:nrow(x), fun =  function(y) {
               combn(x$w , y, sum)
    })
    Values <- parLapplyLB(cluster,1:nrow(x), fun =  function(y) {
             combn(x$v , y , sum)

    })
    stopCluster(cluster) #shutdown cluster
    Combinations_vector <- unlist(Combinations) # creating vectors by unlisting
    Weights_vector <- unlist(Weights)
    Values_vector <- round(unlist(Values))

    Capacity_weight <- which(Weights_vector < W) #using which to get the indexes of weight
    validValues <- Values_vector[Capacity_weight]
    maxValue <- max(validValues)

    Value_Combinations <- which(Values_vector == maxValue) # using which to get the maximum Value
    validCombination <- Combinations_vector[Value_Combinations]

    best_combination <- list(value = maxValue, elements = validCombination) #creating a list
    }
    return(best_combination)
}

system.time(brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500, parallel = TRUE))
system.time(brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500))
system.time(brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500, parallel = TRUE))
system.time(brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500))
system.time(brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000, parallel = TRUE))
system.time(brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000))
system.time(brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000, parallel = TRUE))
system.time(brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000))

brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500, parallel = TRUE)
brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500, parallel = TRUE)
brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000, parallel = TRUE)
brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000, parallel = TRUE)

