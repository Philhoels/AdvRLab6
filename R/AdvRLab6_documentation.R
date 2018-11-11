#' AdvRLab6: A package which solves the knapsack problem on three different ways
#'
#' The AdvRLab6 package provides three  functions:
#' brute_force_knapsack, dynamic_knapsack and greedy_knapsack
#'
#' @section brute_force_knapsack function:
#'The only solution that is guaranteed to give a correct answer in all situations
#' for the knapsack problem is using brute-force search, i.e. going through all possible
#' alternatives and return the maximum value found. This approach is of complexity O(2n)
#' since all possible combinations 2n needs to be evaluated.
#'
#' @section dynamic_knapsack function:
#'If the weights are actually discrete values (as in our example) we can use
#'this to create an algorithm that can solve the knapsack problem exact by iterating
#'over all possible values of w.
#'
#' @section greedy_knapsack function:
#'A last approach is to use the a heuristic or approximation for the problem.
#'This algorithm will not give an exact result (but it can be shown that it will return
#'at least 50% of the true maximum value), but it will reduce the computational complexity
#'considerably (actually to O(n log n) due to the sorting part of the algorithm).
#'
#' @docType package
#' @name AdvRLab6
NULL
#> NULL
