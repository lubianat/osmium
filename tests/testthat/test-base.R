test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("call to EuropePMC works", {
  df <- call_europepmc("20123131")
  expect_equal(df$title[1],
               "Hematopoietic cell types: prototype for a revised cell ontology." )
})

