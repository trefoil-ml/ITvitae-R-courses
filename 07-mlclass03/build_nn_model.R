##################################################################################
# Project:      Neural networks from scratch
# Description:  Building the model
# Data:         moons data set
# By:           Hicham Zmarrou 
# url:          www.trefoil.ml
##################################################################################



# This function learns parameters for the neural network and returns the model.
# - nn_hdim: Number of nodes in the hidden layer
# - num_passes: Number of passes through the training data for gradient descent
# - print_loss: If True, print the loss every 1000 iterations

build_nn_model <- function(nn_hdim,num_passes=20000,X,Y,print_loss = F){
  
  X = as.matrix(moons[,1:2])
  y = as.matrix(moons[,3])
  set.seed(1)
  
  W1 <- read_delim("./data/W1.txt","\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  W1 <- as.matrix(W1)
  #W1  = matrix(rnorm(nn_input_dim*nn_hdim),nn_input_dim, nn_hdim)/sqrt(nn_input_dim)
  b1  = numeric(nn_hdim)
  
  ###########
  W2 <- read_delim("./data/W2.txt", "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
  W2 <- as.matrix(W2)
  #W2  = matrix(rnorm(nn_hdim*nn_output_dim),nn_hdim,nn_input_dim)/sqrt(nn_hdim)
  b2  = numeric(nn_output_dim)
  
  
  model <- list() # This is what we return at the end
  
  for (i in 1:num_passes){
    
    z1 =  X%*%W1 + b1
    a1 =  tanh(z1)
    z2 =  a1%*%W2 + b2
    exp_scores = exp(z2)
    probs = (exp_scores / rowSums(exp_scores))
    
    # Backpropagation
    delta3 =  probs
    delta3 =  delta3 - matrix(c(1-y,y),200,2)
    # delta3[range(num_examples), y] -= 1
    dW2 = t(a1) %*% delta3 
    #dW2 = (a1.T).dot(delta3)
    db2 = colSums(delta3)
    delta2 = delta3  %*% t(W2) * (1 - (a1^2))
    dW1 = t(X) %*%  delta2
    db1 = colSums(delta2)
    
    # Add regularization terms (b1 and b2 don't have regularization terms)
    dW2 <-  dW2 + reg_lambda*W2
    dW1 <-  dW1 + reg_lambda*W1
    
    # Gradient descent parameter update
    W1 <- W1 - epsilon * dW1
    b1 <- b1 - epsilon * db1
    W2 <- W2 - epsilon * dW2
    b2 <- b2 - epsilon * db2
    
    model$W1 =  W1
    model$b1 =  b1
    model$W2 =  W2
    model$b2 =  b2
    
    # Optionally print the loss.
    # # This is expensive because it uses the whole dataset, so we don't want to do it too often.
    
    if ((print_loss == TRUE)  & (i %% 1000 == 0)) {
      print(paste("Loss after iteration", i , ": " , calculate_nn_loss(model)))
    }

  }
  # Optionally print the loss.
  # # This is expensive because it uses the whole dataset, so we don't want to do it too often.
  return(model)             
} 




