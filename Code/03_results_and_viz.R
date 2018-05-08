## Vizualizes results of creating DTMs based on neoliberal elitism
## dictionary with wordclouds, tables, party-specific barplots, and a
## comparative stacked barplot.


library(wordcloud)
library(wordcloud2) # for wordclouds
library(RColorBrewer) # for color palettes
library(kableExtra)
library(ggplot2)
library(dplyr)

rep_results <- as.data.frame(as.table(RepSums))
dem_results <- as.data.frame(as.table(DemSums))

colnames(rep_results) <- c("Term", "Freq")
colnames(dem_results) <- c("Term", "Freq")


wordcloud2(rep_results, color = brewer.pal(4,"Reds"), 
backgroundColor = "grey")

wordcloud2(dem_results, color = brewer.pal(4, "Blues"), 
           backgroundColor = "grey")

 
# par(mfrow=c(1,2))
# #Create word cloud of Rep results
# wordcloud(rep_results$Term, rep_results$Freq,  
#           colors= c("indianred1","indianred2","indianred3",
#                     "indianred"))
# #Create word cloud of Dem results
# wordcloud(dem_results$Term, dem_results$Freq,
#           colors= c("lightsteelblue1","lightsteelblue2",
#                     "lightsteelblue3","lightsteelblue"))


rep_results_order <- rep_results[rev(order(rep_results$Freq)), ]

dem_results_order <- dem_results[rev(order(dem_results$Freq)), ]

pdf("Republican_Elitism.pdf", height = 11, width = 8.5)
barplot(rep_results_order[1:10,]$Freq, las = 2, 
        names.arg = rep_results_order[1:10,]$Term,
        col ="red", main ="Republican Elitism?",
        ylab = "Term Frequencies")
dev.off()


pdf("Democratic_Elitism.pdf", height = 11, width = 8.5)
barplot(dem_results_order[1:10,]$Freq, las = 2, 
        names.arg = dem_results_order[1:10,]$Term,
        col ="lightblue", main ="Democratic Elitism?",
        ylab = "Term Frequencies")
dev.off()



results <- merge(rep_results, dem_results, by = "Term")
colnames(results) <- c("Term", "Republicans", "Democrats")

results_order <- results[rev(order(results$Democrats)), ]

top_results_order <- results_order[1:15, ]

graph_results_order <- melt(top_results_order)
colnames(graph_results_order) <- c("Term", "Party", "Frequency")


pdf("Party_Comparison.pdf", height = 11, width = 8.5)
ggplot(graph_results_order, aes(x=Term, y = Frequency, fill = Party,
  color= Party, alpha = Party)) +
  geom_bar(stat = "identity", position = "identity") + coord_flip() +
  scale_colour_manual(values=c("red","lightblue4")) +
  scale_fill_manual(values=c("pink","lightblue")) +
  scale_alpha_manual(values=c(.3, .6)) +  
  theme(legend.position = "top")
dev.off()

# Another graphing option -- may try later
# ggplot(graph_results_order, aes(x=Term, y=Frequency)) +
#                    geom_bar(stat = "identity", position = "dodge") + 
#                    coord_flip() + facet_wrap(~ Party)
                


