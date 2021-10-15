setwd("~/R/Exercises")
rstan_options(auto_write = TRUE)
#70 subjects 
#46 were categorized as less experienced (LE)
#24 were cat. as more experienced (ME)
#evaluate two techniques, NT & OT
#2x2 design 
library(rethinking)
#measured through true positives (tp)

#which technique is better? 
#is there a difference between Less experienced and More experienced subjects? 
#Steps:
#1.Data story 
#2.bayesian updating 
#3.Evaluate model 

# assumptions (priors): Normal(0,10) ? dont really know much about the subjects. Theyre human? 
# 

d <- read.csv(file="data_autumn2020.csv", sep=";", stringsAsFactors=FALSE)


NewTechLessExperienced <- d$tp[d$technique == "NT" & d$category == "ME"]
NewTechMoreExperienced <- d$tp[d$technique == "NT" & d$category == "LE"]

OldTechMoreExperienced<- d$tp[d$technique == "OT" & d$category == "ME"]
OldTechLessExperienced<- d$tp[d$technique == "OT" & d$category == "LE"]

df <- d$technique[-36]
NTALL <- d$tp[d$technique=="NT"]
NTALL
mean(NTALL)
sd(NTALL)
OTALL <- d$tp[d$technique == "OT"]
mean(OTALL)
sd(OTALL)

d[72,3] <- "OT"
