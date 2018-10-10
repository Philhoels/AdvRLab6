#' @title
#' greedy_knapsack
#' @description greedy_knapsack function to solve the knapsack problem
#' @name
#' greedy_knapsack
#'
#' @param x , is the input weight
#' @param W , is the input value 
#'
#'
#' @return list , returns a list that contain the maximum value and the list of elements chosen
#' @export

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

#greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
#greedy_knapsack(x = knapsack_objects[1:1200,], W = 2000)



