
##  prepare and read the data 
read_and_prepare_titanic_dataset <- function(f) {
  require(dplyr)
  clean_titanic <-  read.csv(f)
  
  
  ## names 
  # Rename every person by his/her title only:
  
  clean_titanic$name <-  gsub(".*Master.*", "Master", clean_titanic$name)
  clean_titanic$name <-  gsub(".*Miss.*", "Miss", clean_titanic$name)
  clean_titanic$name <-  gsub(".*Mrs.*", "Mrs", clean_titanic$name)
  clean_titanic$name <-  gsub(".*Dr.*", "Dr", clean_titanic$name)
  clean_titanic$name <-  gsub(".*Mr. .*", "Mr", clean_titanic$name)
  # Replace NA by the value in the sex columns  
  clean_titanic[!is.na(clean_titanic$name) & !clean_titanic$name %in%  c("Master","Miss","Mrs","Mr","Dr"), "name"] <- NA
  clean_titanic[is.na(clean_titanic$name), "name"] <- if_else(clean_titanic$sex== "male", "Mrs", "Miss")[is.na(clean_titanic$name)]
  
  
  ## Clean Age   
  # Making Inference on Missing (NA) age Values: Inputting Title-group
  # averages:
  master_age = round(mean(clean_titanic$age[clean_titanic$name == "Master"], na.rm = TRUE),digits = 2)
  miss_age   = round(mean(clean_titanic$age[clean_titanic$name == "Miss"], na.rm = TRUE), digits = 2)
  mrs_age    = round(mean(clean_titanic$age[clean_titanic$name == "Mrs"], na.rm = TRUE), digits = 2)
  mr_age     = round(mean(clean_titanic$age[clean_titanic$name == "Mr"], na.rm = TRUE), digits = 2)
  dr_age     = round(mean(clean_titanic$age[clean_titanic$name == "Dr"], na.rm = TRUE), digits = 2)
  
  for (i in 1:nrow(clean_titanic)) {
    if (is.na(clean_titanic[i, 5])) {
      if (clean_titanic$name[i] == "Master") {
        clean_titanic$age[i] = master_age
      } else if (clean_titanic$name[i] == "Miss") {
        clean_titanic$age[i] = miss_age
      } else if (clean_titanic$name[i] == "Mrs") {
        clean_titanic$age[i] = mrs_age
      } else if (clean_titanic$name[i] == "Mr") {
        clean_titanic$age[i] = mr_age
      } else if (clean_titanic$name[i] == "Dr") {
        clean_titanic$age[i] = dr_age
      } else {
        print("Uncaught Title")
      }
    }
  }
  
  ##
  # Embarkation is Southampton by default
  clean_titanic["embarked_C"] = ifelse(clean_titanic$embarked == "C", 1, 0)
  clean_titanic["embarked_Q"] = ifelse(clean_titanic$embarked == "Q", 1, 0)
  # Remove 'Embarked' variable
  clean_titanic =clean_titanic %>% dplyr::select(-embarked)
  ##
  
  ## Create a child  variable 
  clean_titanic$child  <- NA  
  clean_titanic$child  <- if_else(clean_titanic$age <=12,1,0)
  
  ## Create fam 
  
  #clean_titanic$fam   <- clean_titanic$sibsp + clean_titanic$parch  
  
  ## Create mother  
  
  clean_titanic$mother <- NA  
  clean_titanic$mother <- if_else((clean_titanic$name == "Mrs" & clean_titanic$parch > 0), 1,0) 
  
  
  ## categorical to factors data structures   
  # convert categorical variables  to factors 
  #clean_titanic$pclass   <- as.factor(clean_titanic$pclass)
  clean_titanic$survived <- as.factor(clean_titanic$survived)
  clean_titanic$mother   <- as.factor(clean_titanic$mother)
  clean_titanic$child    <- as.factor(clean_titanic$child)
  clean_titanic$sex      <- as.factor(clean_titanic$sex)
  
  #clean_titanic$fam      <- as.numeric(clean_titanic$fam)
  ## 
  
  clean_titanic <- clean_titanic %>% dplyr::select(survived,name,pclass,sex,age,sibsp,parch,fare,embarked_C,embarked_Q,child,mother) 
  
  return(clean_titanic)
}