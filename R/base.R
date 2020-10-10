library(europepmc)


run_osmium <- function(pmid) {
  a <- epmc_details(pmid)

  pmid <- a$basic$pmid
  title <- a$basic$title
  doi <- a$basic$doi
  citations <- a$basic$citedByCount

  pages <- calculate_pages(a$basic$pageInfo)
  osmium <- NA
  date <- Sys.Date()

  result <- data.frame(pmid, title, doi, citations, pages, osmium, date, stringsAsFactors = FALSE)

  return(result)
}

calculate_pages <- function(page_string){

  tryCatch(
    expr =  {
      diff <- eval(parse(text=page_string))
      n_pages = abs(diff) + 1
    },
    error = function(e) {
      n_pages <- NA
    }
  )

  return(n_pages)
}


calculate_density <- function(n_pages, n_citations, alpha = 1){
    density = n_citations / (n_pages ** alpha)
    return(density)

}

