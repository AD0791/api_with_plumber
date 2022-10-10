library("plumber")

pr("plumber.R") %>%
pr_get("/", function(){
    "<html><h1>Programmatic Plumber!</h1></html>"
  }, 
  serializer = serializer_html()
) %>%
pr_set_error(function(req, res, err) {
    res$status <- 500
    list(error = "An error occurred. Please contact your administrator.")
  }
) %>%
pr_run(port = 8000)
