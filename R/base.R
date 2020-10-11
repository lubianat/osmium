#' @import dplyr
#' @import europepmc
NULL

#' Runs osmium for multiple PMIDs
#' @param pmids A character vector of PMIDs
#' @param density_alpha A density_alpha to modulate the weight of pages
#' @param sleep The number of seconds to wait between API calls. Defaults to 0.5.
#' @export
run_multiple_osmium <- function(pmids, density_alpha = 1, sleep = 0.5) {
  list_of_results <- list()
  for (pmid in pmids) {
    Sys.sleep(0.3)
    print(pmid)
    tryCatch(
      expr = {
        df <- run_single_osmium(pmid, density_alpha)
        list_of_results[[pmid]] <- df
      },
      error = function(e) {
        sprintf("Failed for %s", pmid)
      }
    )
  }
  result <- bind_rows(list_of_results)
  return(result)
}


run_single_osmium <- function(pmid, density_alpha) {
  a <- epmc_details(pmid)
  if (is.null(a)) {
    return(NULL)
  }
  if (is.null(a$basic$pageInfo)) {
    return(NULL)
  }
  pmid <- a$basic$pmid
  title <- a$basic$title
  doi <- a$basic$doi
  citations <- a$basic$citedByCount

  pages <- calculate_pages(a$basic$pageInfo)

  osmium_score <- calculate_density(pages,
    citations,
    alpha = density_alpha
  )
  osmium <- round(osmium_score, 3)
  alpha <- density_alpha
  date <- Sys.Date()

  result <- data.frame(pmid, title, doi, citations,
    pages, osmium, alpha, date,
    stringsAsFactors = FALSE
  )

  return(result)
}

calculate_pages <- function(page_string) {
  tryCatch(
    expr = {
      diff <- eval(parse(text = page_string))
      n_pages <- abs(diff) + 1
      return(n_pages)
    },
    error = function(e) {
      n_pages <- NA
      return(n_pages)
    }
  )
}


calculate_density <- function(n_pages, n_citations, alpha) {
  if (is.na(n_pages)) {
    return(NA)
  }
  density <- n_citations / (n_pages**alpha)
  return(density)
}
