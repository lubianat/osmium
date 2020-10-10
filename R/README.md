# Osmium: A Simple Citation Density Calculator

Ranks articles by citation density (citations/page).

 - Gets a list of PMIDs
 - Returns a dataframe containing:
    - pmid: The PubMed ID
    - citations: The citations according to Europe PMC
    - pages: The number of pages, inferred from Europe PMC
    - osmium: The density score 
    - date: The date of search
