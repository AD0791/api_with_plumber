library("plumber")
#* @apiTitle Sample Pet Store App
#* @apiDescription This is a sample server for a pet store.
#* @apiTOS http://example.com/terms/
#* @apiContact list(name = "API Support", url = "http://www.example.com/support", email = "support@example.com")
#* @apiLicense list(name = "Apache 2.0", url = "https://www.apache.org/licenses/LICENSE-2.0.html")
#* @apiVersion 1.0.1



plb_routes = pr("plumber.R")
hookie_routes = pr("hookie.R")

pr()%>%
pr_set_api_spec(function(spec) {
    spec$info <- list(
      title = "Sample Pet Store App",
      description = "This is a sample server for a pet store.",
      termsOfService = "http://example.com/terms/",
      contact = list(name = "API Support", url = "http://www.example.com/support", email = "support@example.com"),
      license = list(name = "Apache 2.0", url = "https://www.apache.org/licenses/LICENSE-2.0.html"),
      version = "1.0.1"
    )
    spec$tags <- list(list(name = "plb", description = "Pets operations"), list(name = "hookie", description = "Toys operations"))
    spec
  })%>%
pr_mount("/hookies",hookie_routes) %>%
pr_mount("/plumbs",plb_routes) %>%
pr_run(port = 8000)
