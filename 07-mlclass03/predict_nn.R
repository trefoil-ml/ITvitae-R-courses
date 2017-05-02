##################################################################################
# Project:      Neural networks from scratch
# Description:  Helper function to predict an output (0 or 1)
# Data:         moons data set
# By:           Hicham Zmarrou 
# url:          www.trefoil.ml
##################################################################################

# We also implement a helper function to calculate the output of the network. 
# It does forward propagation as defined above and returns the class with the highest probability.


predict_nn <- function(model, X){
  
  
  # load the model parameters
  
  W1 = model$W1    
  b1 = model$b1
  W2 = model$W2
  b2 = model$b2

  # Forward propagation to calculate our predictions
  z1         = X%*%W1 + b1
  a1         = tanh(z1)
  z2         = a1%*%W2 + b2
  exp_scores = exp(z2)
  
  probs      = exp_scores/rowSums(exp_scores)
  apply(probs, 1, which.max) - 1 
  return (apply(probs, 1, which.max) - 1)
}
  
  
  