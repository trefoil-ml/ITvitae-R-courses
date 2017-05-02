##################################################################################
# Project:      Neural networks from scratch
# Description:  Calculate Loss function
# Data:         moons data set
# By:           Hicham Zmarrou 
# url:          www.trefoil.ml
##################################################################################

# Helper function to evaluate the total loss on the dataset
# Helper function to evaluate the total loss on the dataset


calculate_nn_loss <- function(model){
  
  
  # load the model parameters
  #X  = X ; y =y
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
  probsXum   = rowSums(probs * cbind( (1-y),y)) 
  # Calculating the loss
  
  corect_logprobs = -log(probsXum)
  data_loss       =  sum(corect_logprobs)
  
  # Add regulatization term to loss (optional)
  
  data_loss  =   data_loss + reg_lambda/2 * (sum(W1^2) + sum(W2^2))
  return (1/ num_examples * data_loss)
}
  
  
  