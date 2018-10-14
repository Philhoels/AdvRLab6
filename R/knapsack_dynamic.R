# 1.1.3 Dynamic Programming
# knapsack_dynamic(x, W)
# Roxygen2 documentation
#' @title knapsack_dynamic
#'
#' @description a dynamic function to solve the knapsack problem
#'
#' @param x , the input data frame
#' @param W , the knapsack size variable
#'
#' @return  #------------- need to add
#' @export

# pseudo code for the dynamic program - wikipedia
# Input:
# Values (stored in array v)
# Weights (stored in array w)
# Number of distinct items (n)
# Knapsack capacity (W)
# NOTE: The array "v" and array "w" are assumed to store all relevant values starting at index 1.
#
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

# Define value[n, W]
#
# Initialize All value[i, j]=-1
#
# Define m:=(i,j)         //Define function m so that it represents the maximum value we can get under the condition: use first i items, total weight limit is j
# {
#   if i=0 then:
#     return 0
#   if j<0 or j=0 then:
#     return 0
#   if(value[i-1, j]!=-1) then:     //m[i-1, j] has been calculated and it is stored in value[i-1, j]
#   temp_1=value[i-1, j]
#   else
#     temp_1=m(i-1,j)               //m[i-1, j] has not been calculated, we have to call function m
#   if(value[i-1,j-w[i]]!=-1) then: //m[i-1,j-w[i]] has been calculated and it is stored in value[i-1,j-w[i]]
#   temp_2=value[i-1,j-w[i]]+v[i]
#   else
#     temp_2=m(i-1,j-w[i])+v[i])    //m[i-1,j-w[i]] has not been calculated, we have to call function m
# backvalue=max(temp_1,temp_2)
# value[i, j]=backvalue;//If function m is called, then the vlue of m(i,j) will be calculated and in the future there is no need for repeated calculation.So, store it!
#   return backvalue
# }
#
# Run m(n,W)

#-------------------------------------- Pseudo code transformed to R for the dynamic program:
#
# # The function - knapsack_dynamic(x, W)
# knapsack_dynamic <- function(x, W){
#   # for (j in 0:W) {
#   #   x[0,j] <- 0
#   # }
#   # for (i in 1:n) {
#   #   for (j in 0:W) {
#   #     if(x$w [i] > j){
#   #       x[i,j] <- x[i-1,j]
#   #     } else{
#   #       x[i,j] <- max(x[i-1,j], x[i-1, j- x$w[[i]]] + v[i])
#   #     }
#   #   }
#   # }
#   # return(x)
#
#   for (j in 0:W) {
#     x[0,j] <- 0
#   }
#   for (i in 1:n) {
#     for (j in 0:W) {
#       if(w[i] > j){
#         x[i,j] <- x[i-1, j]
#       } else{
#         x[i,j] <- max(x[i-1,j], x[i-1, j-w[i]] + v[i])
#       }
#     }
#   }
# }
#
#
# #-------------------------------------- TEST
# knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500)
# knapsack_objects[1:8,]
#
#
#
# n <- c(0,1,2,3,4)
# v <- c(10,40,30,50)
# w <- c(5,4,6,3)
# k <- 10
# myfunction  <- function(i,k){
#   if (i==0 || k==0){
#     output <- 0
#   } else if (length( w[i]) && w[i] > k) {
#     output <- myfunction(i-1,w)
#   } else {
#     output <- max(v[i]+ myfunction(i-1, k-w[i]), myfunction(i-1,k))
#   }
#   return(output)
# }
#
# myfunction(4,10)


