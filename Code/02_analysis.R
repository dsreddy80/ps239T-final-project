
## Subsets and prepares data for text analysis using tm package. 
## Creates general and party-specific DTMs of all words.  
## Conducts descriptive analysis to find correlations among terms 
## to inform "neoliberal elitism" dictionary.  
## Creates general and party-specific DTMs of neoliberal elitist 
## rhetoric.

# Install and load packages -- currently using

require(tm) # Framework for text mining
require(dplyr)

# Install and load packages -- may use in future analysis 

require(ggplot2) # for plotting word frequencies
require(RTextTools) # a machine learning package for text classification written in R
require(qdap) # Quantiative discourse analysis of transcripts
require(qdapDictionaries)
require(SnowballC) # for stemming
library(data.table)
library(wordcloud2) # for wordclouds
library(RColorBrewer) # for color palettes


# Subset speeches.df from 01_import_and_clean for text analysis,
# remove debate observations (could break apart into Dem and Rep
# segments later on, if wanted to use them)

table(speeches.df$Genre)

sub.speeches.df <- filter(speeches.df, Genre=="SPEECH"|Genre =="AD")

dem.sub.speeches.df <-  filter(sub.speeches.df, Party=="Democrat")

rep.sub.speeches.df <-  filter(sub.speeches.df, Party=="Republican")

# Create overall corpus, and Dem And Repub corpuses

sub.speech.corp <- Corpus(VectorSource(sub.speeches.df$Text))

dem.sub.speech.corp <- Corpus(VectorSource(dem.sub.speeches.df$Text))

rep.sub.speech.corp <- Corpus(VectorSource(rep.sub.speeches.df$Text))


# Create overall document term matrix

sub.speech.dtm <- DocumentTermMatrix(sub.speech.corp,
                          control = list(tolower = TRUE,
                                         removePunctuation = TRUE,
                                         removeNumbers = TRUE,
                                         stopwords = TRUE))
# How many terms overall?

freq <- colSums(as.matrix(sub.speech.dtm))
length(freq)


# order terms
ord <- order(freq)

# Least frequent terms overall
freq[head(ord)]

# Most frequent terms overall
freq[tail(ord)]

# frequency of frequencies
head(table(freq),15)
tail(table(freq),15)

# Words that appear at least 2500 times

findFreqTerms(sub.speech.dtm, lowfreq=2500)

# Find correlations with "neoliberal elitism" initial dictionary
# to inform additional term selection

findAssocs(sub.speech.dtm, "top", 0.2)
findAssocs(sub.speech.dtm, "best", 0.3)
findAssocs(sub.speech.dtm, "opportunity", 0.3)
findAssocs(sub.speech.dtm, "opportunities", 0.2)
findAssocs(sub.speech.dtm, "potential", 0.2)
findAssocs(sub.speech.dtm, "risk", 0.2)
findAssocs(sub.speech.dtm, "investment", 0.3)
findAssocs(sub.speech.dtm, "market", 0.3)
findAssocs(sub.speech.dtm, "markets", 0.3)
findAssocs(sub.speech.dtm, "compete", 0.3)
findAssocs(sub.speech.dtm, "competition", 0.3)


# Create matrix matching terms in elitism dictionary to documents

elitism_matrix <- DocumentTermMatrix(sub.speech.corp, control = 
                             list(dictionary = c(
                               "potential", 
                               "merit", 
                               "talent", 
                               "optimal", 
                               "risk", 
                               "efficient",
                               "efficiency",
                               "efficiencies",
                               "best",
                               "brightest",
                               "rank",
                               "ranked",
                               "highly-ranked",
                               "top",
                               "brain",
                               "brains",
                               "market",
                               "markets",
                               "marketplace",
                               "braintrust",
                               "braintrusts",
                               "brainpower",
                               "entrepreneurs",
                               "entrepreneur",
                               "entreprenerial",
                               "profit",
                               "profits",
                               "profitable",
                               "investment",
                               "competition",
                               "competitive",
                               "compete",
                               "competes",
                               "opportunity",
                               "opportunities",
                               "incentive",
                               "incentives",
                               "incentivize",
                               "privatize",
                               "talented",
                               "creative",
                               "innovate",
                               "innovates",
                               "innovator",
                               "innovators",
                               "innovation",
                               "grow",
                               "growth",
                               "create",
                               "creates",
                               "creators")))


# Display totals by term in elitism dictionary for all documents

colSums(as.matrix(elitism_matrix))

# Create matrix matching terms in elitism dictionary to 
# Democratic documents

dem_elitism_matrix <-DocumentTermMatrix(dem.sub.speech.corp, control = 
                                   list(dictionary = c(
                                     "potential", 
                                     "merit", 
                                     "talent", 
                                     "optimal", 
                                     "risk", 
                                     "efficient",
                                     "efficiency",
                                     "efficiencies",
                                     "best",
                                     "brightest",
                                     "rank",
                                     "ranked",
                                     "highly-ranked",
                                     "top",
                                     "brain",
                                     "brains",
                                     "market",
                                     "markets",
                                     "marketplace",
                                     "braintrust",
                                     "braintrusts",
                                     "brainpower",
                                     "entrepreneurs",
                                     "entrepreneur",
                                     "entreprenerial",
                                     "profit",
                                     "profits",
                                     "profitable",
                                     "investment",
                                     "competition",
                                     "competitive",
                                     "compete",
                                     "competes",
                                     "opportunity",
                                     "opportunities",
                                     "incentive",
                                     "incentives",
                                     "incentivize",
                                     "privatize",
                                     "talented",
                                     "creative",
                                     "innovate",
                                     "innovates",
                                     "innovator",
                                     "innovators",
                                     "innovation",
                                     "grow",
                                     "growth",
                                     "create",
                                     "creates",
                                     "creators")))

# Display totals by term in elitism dictionary for Democratic 
# documents

colSums(as.matrix(dem_elitism_matrix))

DemSums <- colSums(as.matrix(dem_elitism_matrix))


# Create matrix matching terms in elitism dictionary to 
# Republican documents

rep_elitism_matrix <- DocumentTermMatrix(rep.sub.speech.corp, control = 
                                    list(dictionary = c(
                                      "potential", 
                                      "merit", 
                                      "talent", 
                                      "optimal", 
                                      "risk", 
                                      "efficient",
                                      "efficiency",
                                      "efficiencies",
                                      "best",
                                      "brightest",
                                      "rank",
                                      "ranked",
                                      "highly-ranked",
                                      "top",
                                      "brain",
                                      "brains",
                                      "market",
                                      "markets",
                                      "marketplace",
                                      "braintrust",
                                      "braintrusts",
                                      "brainpower",
                                      "entrepreneurs",
                                      "entrepreneur",
                                      "entreprenerial",
                                      "profit",
                                      "profits",
                                      "profitable",
                                      "investment",
                                      "competition",
                                      "competitive",
                                      "compete",
                                      "competes",
                                      "opportunity",
                                      "opportunities",
                                      "incentive",
                                      "incentives",
                                      "incentivize",
                                      "privatize",
                                      "talented",
                                      "creative",
                                      "innovate",
                                      "innovates",
                                      "innovator",
                                      "innovators",
                                      "innovation",
                                      "grow",
                                      "growth",
                                      "create",
                                      "creates",
                                      "creators")))

# Display totals by term in elitism dictionary for Republican 
# documents

colSums(as.matrix(rep_elitism_matrix))

RepSums <- colSums(as.matrix(rep_elitism_matrix))
