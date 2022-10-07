library("plumber")

pr("plumber.R") %>%
pr_set_error(function(req, res, err) {
    res$status <- 500
    list(error = "An error occurred. Please contact your administrator.")
  }
) %>%
pr_run(port = 8000)
