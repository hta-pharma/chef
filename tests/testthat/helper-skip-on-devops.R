skip_on_devops <- function() {
  if (!identical(Sys.getenv("ON_DEVOPS"), "TRUE")) {
    return(invisible(TRUE))
  }
  testthat::skip("On DevOps")
}
