library(europepmc)


call_europepmc <- function(pmid){

  a <- epmc_details(pmid)

  pmid <- a$basic$pmid
  title <- a$basic$title
  doi <- a$basic$doi
  citations <- a$basic$citedByCount

  pages <- NA
  osmium <- NA
  date <- Sys.Date()

  result <- data.frame(pmid, title, doi, citations, pages, osmium, date, stringsAsFactors = FALSE)

  return(result)


}


call_europepmc("20123131")
