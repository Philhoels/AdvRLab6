#' @title brute_force_knapsack
#' @description Brute_force_knapsack function to solve the knapsack problem
#' @name Brute_force_knapsack
#'
#' @param x Dataframe with variables v and w.
#' @param W Integer as capacity.
#'
#' @importFrom utils combn
#' @return list , returns a list that contain the best value and combination
#' @export


brute_force_knapsack <- function(x,W, parallel = FALSE){

  stopifnot(is.data.frame(x)|| W < 0,is.numeric(W))
  if(parallel == FALSE){
    ListofCombinations <- list()
    for(i in 1:nrow(x))
    {
      ListOfCombinations[[i]] <- combn(rownames(x), i, paste, collapse = " ")
    }

    ListOfWeights <- list()
    for(i in 1:nrow(x))
    {
      ListOfWeights[[i]] <- combn(x$w, i,sum)
    }

    ListOfValues <- list()
    for(i in 1:nrow(x) )
    {
      ListOfValues[[i]] <- combn(x$v, i, sum)
    }
    Combinations <- unlist(ListOfCombinations)
    Weights <- unlist(ListOfWeights)
    Values <- round(unlist(ListOfValues),0)

    weightsUnderCapacity <- which(Weights < W)
    validValues <- Values[weightsUnderCapacity]
    maximumValidValue <- max(validValues)

    validCombinationsVector <- which(Values == maximumValidValue)
    validCombination <- Combinations[validCombinationsVector]

    bestCombinationList <- list(value = maximumValidValue, elements = as.numeric(strsplit(validCombination, " ")[[1]]))
  }else{
    numberOfCores <- detectCores() - 1
    cluster <- makeCluster(numberOfCores)
    clusterExport(cluster , c("x") ,envir = environment())

    ListOfCombinations <- parLapplyLB(cluster, 1:nrow(x), fun =  function(y) {
      combn(rownames(x) , y , paste0, collapse = " ")
    })
    ListOfWeights <- parLapplyLB(cluster, 1:nrow(x), fun =  function(y) {
      combn(x$w , y, sum)
    })
    ListOfValues <- parLapplyLB(cluster,1:nrow(x), fun =  function(y) {
      combn(x$v , y , sum)
    })

    stopCluster(cluster)

    Combinations <- unlist(ListOfCombinations)
    Weights <- unlist(ListOfWeights)
    Values <- round(unlist(ListOfValues),0)

    weightsUnderCapacity <- which(Weights < W)
    validValues <- Values[weightsUnderCapacity]
    maximumValidValue <- max(validValues)

    validCombinationsVector <- which(Values == maximumValidValue)
    validCombination <- Combinations[validCombinationsVector]

    bestCombinationList <- list(value = maximumValidValue, elements = as.numeric(strsplit(validCombination, " ")[[1]]))
  }
  return(bestCombinationList)
}

#set.seed(42)
#n <- 2000
#knapsack_objects <-
#  data.frame(
#    w=sample(1:4000, size = n, replace = TRUE),
#    v=runif(n = n, 0, 10000)
#  )
#ptm <- proc.time()
#brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500,parallel = TRUE)
#proc.time() - ptm

