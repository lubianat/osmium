test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("run_multiple_osmium runs", {
  pmids <- c("20123131", "15892874", "notanid")
  df <- run_multiple_osmium(pmids, density_alpha = 1)

  expect_equal(
    df$title[1],
    "Hematopoietic cell types: prototype for a revised cell ontology."
  )
  expect_equal(
    df$doi[1],
    "10.1016/j.jbi.2010.01.006"
  )

  expect_equal(
    df$pages[1],
    5
  )

  expect_equal(
    df$alpha[1],
    1
  )

  # The number of citations for this article
  # Might increase in the future
  current_density <- 16 / 5 - 0.00001
  expect_gt(
    df$osmium[1],
    current_density
  )
})



test_that("run_single_osmium runs", {
  pmids <- c("31322498")
  df <- run_single_osmium(pmids, density_alpha = 1)
})

test_that("calculate_pages work", {
  result <- calculate_pages("75 - 79")
  expected <- 5
  expect_equal(result, expected)
})

test_that("calculate_density work", {
  result <- calculate_density(
    n_pages = 5,
    n_citations = 100,
    alpha = 1
  )
  expected <- 20
  expect_equal(result, expected)

  result <- calculate_density(
    n_pages = 5,
    n_citations = 100,
    alpha = 2
  )
  expected <- 4
  expect_equal(result, expected)

  result <- calculate_density(
    n_pages = 5,
    n_citations = 100,
    alpha = 3
  )
  expected <- 0.8
  expect_equal(result, expected)

  result <- calculate_density(
    n_pages = NA,
    n_citations = 100,
    alpha = 1
  )
  expected <- NA
  expect_equal(result, expected)
})
