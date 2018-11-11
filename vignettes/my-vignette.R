## ---- echo = FALSE, message = FALSE, warning=FALSE-----------------------
library(profvis)
library(parallel)

## ---- echo=TRUE, eval=FALSE, message=FALSE, results='asis'---------------
#  system.time(brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500))

## ---- echo = TRUE, eval = FALSE, message = FALSE, results='asis'---------
#  system.time(dynamic_knapsack(x = knapsack_objects[1:500,], W = 3500))

## ---- echo=TRUE, eval=FALSE, message=FALSE, results='asis'---------------
#  system.time(greedy_knapsack(x = knapsack_objects[1:1000000,], W = 3500))

## ---- echo=TRUE, eval=FALSE, message=FALSE, results='asis'---------------
#  op <- profvis::profvis(
#    {
#      # the greedy algorithm
#      if(W < 1){
#        stop("The argument W needs to be positive")
#      }
#      #value per weight
#      vpw <- x[,2]/x[,1]
#      x$vpw <- vpw
#      #order
#      x <- x[order(x$vpw, decreasing = TRUE),]
#      weight <- W
#      sum <- 0
#      i <-1
#      elements <- c()
#      nrow <- nrow(x)
#      #sum value until reach the weight
#      for (i in 1:nrow)
#      {
#        if (x$w[i] < weight)
#        {
#          if (weight > 0)
#          {
#            weight <- weight - x$w[i]
#            sum <- sum + x$v[i]
#            elements <- c(elements, as.numeric(row.names(x)[i]))
#          }
#        } else  break()
#      }
#  
#      output <- list(value = round(sum, 0), elements = elements)
#      return(output)
#    })

## ---- echo=TRUE, eval=FALSE, message=FALSE, results='asis'---------------
#  system.time(brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500, parallel = TRUE))

## ------------------------------------------------------------------------
## time dynamic_knapsack function 3.589
## time dynamic_knapsack parallel function 3.381
3.589 - 3.381

