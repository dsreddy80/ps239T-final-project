# ps239T-final-project

Short Description

My project emplopys computerized text analysis, using R, to (1) import raw data from the Annenberg/Pew Archive of Presidential Campaign Discourse and reshape it into tabular format, preserving both existing metadata and document texts; and (2) apply a dictionary of theoretically-informed "neoliberal elitism" terms to these texts to assess how invocation of the terms has differened by political party.  Further applications will include assessing change in term usage over time, with the goal of providing a discursive account of evolving "elitisms" in political rhetoric over time, and particularly over the shift from Fordism to neoliberalism.  

Dependencies 

R version 3.4.3 (2017-11-30)
R Studio Version 1.1.414

Files

data:
1. Data.txt: Manually-compiled file of all raw data from the Annenberg/Pew Archive of Presidential Campaign Discourse, previously available only via a third-party database platform in CD-ROM format, designed for use with Windows XP

2. annenberg_pew_data.csv: Tabular dataset of 3371 observations of 12 variables, combining all meta-data and campaign document text

code:
01_import_and_clean.R: Imports unstructured data from the Annenberg/Pew Archive, reshapes into tabular format and cleans (further cleaning still to be performed), and exports to annenberg_pew_data.csv.

02_analysis.R: Subsets and prepares data for text analysis using tm package. Creates general and party-specific DTMs of all words.  Conducts descriptive analysis to find correlations among terms to inform "neoliberal elitism" dictionary.  Creates general and party-specific DTMs of neoliberal elitist rhetoric.

03_results_and_viz.R: Vizualizes results with wordclouds, tables, party-specific barplots, and comparative barplot.

results:
Democratic_Elitism.pdf: Highest word frequency graph for Dems
Republican_Elitism.pdf: Highest word frequency graph for Repubs
Party_Comparison.pdf: Compares frequency on same terms with overlapping bar graph

More Information

This is active work in project, with its biggest contribution so far being the reshaping of, for continued present-day use, this valuable dataset.  Next steps will include regressions of terms use across time and party.  For further information or to chat methods and political discourse, contact Diana Reddy, dsreddy@berkeley.edu
