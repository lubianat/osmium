test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("run_osmium runs", {
  df <- run_osmium("20123131")

  expect_equal(
    df$title[1],
    "Hematopoietic cell types: prototype for a revised cell ontology."
  )
  expect_equal(
    df$doi[1],
    "10.1016/j.jbi.2010.01.006"
  )
})
