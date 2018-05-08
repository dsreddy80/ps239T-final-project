# ps239T-final-project

## Short Description

My project employs computerized text analysis, using R, towards two goals: (1) to import raw data from the Annenberg/Pew Archive of Presidential Campaign Discourse and reshape it into tabular format, preserving both existing metadata and document texts; and (2) to apply a theoretically-informed dictionary of "neoliberal elitism" to these texts to assess how invocation of the terms has differed by political party.  Further research will include assessing change in term usage over time, with the goal of providing a discursive account of evolving "elitism" in political rhetoric, and particularly over the shift from Fordism to neoliberalism.  

## Dependencies 

R version 3.4.3 (2017-11-30)

R Studio Version 1.1.414

## Files

data:

1. Data.txt: Manually-compiled file of all raw data from the Annenberg/Pew Archive of Presidential Campaign Discourse, previously available only via a third-party database platform in CD-ROM format designed for use with Windows XP

2. annenberg_pew_data.csv: Tabular dataset of 3371 observations of 12 variables, combining all meta-data and campaign document texts from the Archive

code:

01_import_and_clean.R: Imports unstructured data from the Annenberg/Pew Archive, reshapes into tabular format and cleans (further cleaning would be useful), and exports to annenberg_pew_data.csv.

02_analysis.R: Subsets and prepares data for text analysis using tm package. Creates general and party-specific DTMs.  Conducts descriptive analysis to find correlations among terms to inform "neoliberal elitism" dictionary.  Creates general and party-specific DTMs of neoliberal elitist rhetoric.

03_results_and_viz.R: Vizualizes word counts of neoliberal elitist rhetoric by party, with wordclouds, party-specific barplots, and a comparative overlapping barplot.

results:

Democratic_Elitism.pdf: Highest word frequency graph for Dems

Republican_Elitism.pdf: Highest word frequency graph for Repubs

Party_Comparison.pdf: Compares frequency for same terms across both parties, with overlapping barplot

## More Information

This is an active work in process, with its biggest contribution so far being the reshaping of this valuable dataset, for continued present-day use.  Next steps will include regressions of term use over time, by party.  For further information or to chat methods, discourse, and law, contact Diana Reddy, dsreddy@berkeley.edu
