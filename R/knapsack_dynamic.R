# 1.1.3 Dynamic Programming
# knapsack_dynamic(x, W)
# Roxygen2 documentation
#'
#'
#'
#'

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
for (j in 0:W) {
  m[0,j] <- 0
}

for (i in 1:n) {
  for (j in 0:W) {
    if(w[i] > j){
      m[i,j] <- m[i-1,j]
    } else{
      m[i,j] <- max(m[i-1,j], m[i-1,j-w[[i]]] + v[i])
    }
  }
}


# The function - knapsack_dynamic(x, W)
knapsack_dynamic <- function(x, W){

}



