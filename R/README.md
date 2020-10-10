# Osmium: A Simple Citation Density Calculator

Ranks articles by citation density (citations/page).

 - Gets a list of PMIDs
 - Returns a dataframe containing:
    - pmid: The PubMed ID
    - title: The article title
    - doi: The article doi
    - citations: The citations according to Europe PMC
    - pages: The number of pages, inferred from Europe PMC
    - osmium: The density score 
    - alpha: The alpha used for the calculation
    - date: The date of search
