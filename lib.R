################################################################################
# return matrix with normalized columns
################################################################################

normalize_column <- function(matrix) {
  range <- range(matrix, na.rm = T)
  (matrix - range[1]) / diff(range)
}

################################################################################
# return matrix with the sums of cols in the diag
################################################################################

diag_colSums <- function(matrix) {
  diag(colSums(matrix, na.rm = TRUE))
}

################################################################################
# return normalized matrix
################################################################################

normalize <- function(matrix, alpha) {
  d <- diag_colSums(matrix)
  d_a <- diag(diag(d^-alpha))
  d_a %*% matrix %*% d_a
}

################################################################################
# step 3 - apply the graph Laplacian normalization
################################################################################

laplacian_norm <- function(matrix) {
  solve(diag_colSums(normalize(matrix, alpha))) %*% normalize(matrix, alpha)
}

################################################################################
# step 4 - compute the k largest eigenvalues and the corresponding eigenvectors
################################################################################

eigen_matrix <- function(matrix) {
  eigen(t(laplacian_norm(matrix)))
}