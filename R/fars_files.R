#' Read fars csv data.
#'
#' Read the fars data file in csv format. Return an error if the file does not
#' exist.
#'
#' @param filename character; name of the file.
#'
#' @return a tibble containing the fars data.
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @examples
#' \dontrun{
#' fars_read(fars_data.csv)
#' }
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#' Create the file name.
#'
#' Create the file name from the year passed to the function using the format
#' accident_year.csv.bz2.
#'
#' @param year the year that will appear in the name of the file.
#'
#' @return a character representing the name of the file.
#'
#' @examples
#' \dontrun{
#' make_filename(2014)
#' }
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}

#' Read the fars data from different years.
#'
#' For each year passed as argument, read the fars data, create a column with
#' the year and select the month and the year. Return an error if the year is
#' not valid. The files must be in the working directory.
#'
#' @param years vector or list; the years that will be read.
#'
#' @return a list of tibbles containing the data for the years.
#'
#' @importFrom dplyr mutate select
#'
#' @examples
#' \dontrun{
#' fars_read_years(c(2014, 2015))
#' }
#'
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}
