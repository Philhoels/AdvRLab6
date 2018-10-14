## ----message=FALSE, warning=FALSE----------------------------------------
set.seed(42)
n <- 2000
knapsack_objects <-data.frame(
  w=sample(1:4000, size = n, replace = TRUE),
  v=runif(n = n, 0, 10000)
)


## ------------------------------------------------------------------------
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
  Values_vector <- round(unlist(Values),0)

  Capacity_weight <- which(Weights_vector < W) #using which to get the indexes of weight
  validValues <- Values_vector[Capacity_weight]
  maxValue <- max(validValues)

  Value_Combinations <- which(Values_vector == maxValue) # using which to get the maximum Value
  validCombination <- Combinations_vector[Value_Combinations]

  best_combination <- list(value = maxValue, elements = validCombination) #creating a list
  return(best_combination)
}


## ----message=FALSE, warning=FALSE----------------------------------------
ptm <- proc.time()
brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500)
result <- proc.time() - ptm
result

## ------------------------------------------------------------------------


## ------------------------------------------------------------------------


## ------------------------------------------------------------------------
greedy_knapsack <- function(x,W)
{
  #value per weight
  vpw <- x[,2]/x[,1]
  x$vpw <- vpw
  #order
  x <- x[order(x$vpw, decreasing = TRUE),]
  weight <- W
  sum <- 0
  i <-1
  elements <- c()
  nrow <- nrow(x)
  #sum value until reach the weight
  for (i in 1:nrow)
  {
    if (x$w[i] < weight)
      {
    if (weight > 0)
        {
        weight <- weight - x$w[i]
        sum <- sum + x$v[i]
        elements <- c(elements, as.numeric(row.names(x)[i]))
        }
      } else  break()
  }

  output <- list(value = round(sum, 0), elements = elements)
return(output)
}


## ------------------------------------------------------------------------

ptm <- proc.time()
greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
result <- proc.time() - ptm
result


