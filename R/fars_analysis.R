#' Sumarize years of fars data.
#'
#' Create a table containing the the number of fars where the months are
#' represented as rows and the years as columns.  The files must be in the
#' working directory.
#'
#' @param years vector or list; the years that will be read.
#'
#' @return a tibble containing the number of fars by month and year.
#'
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
#'
#' @examples
#' \dontrun{
#' fars_summarize_years(c(2014, 2015))
#' }
#'
#' @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}

#' Plot the fars data from a specific state and year.
#'
#' Plot the fars cases from a specific year and state in the state map according
#' to the latitude and longitude of the cases. Return an error if the year is
#' not valid or if there are not any cases in the state. Longituds greater than
#' 900 and latituds greater than 90 will not be considered.  The files must be
#' in the working directory.
#'
#' @param state.num numeric; the number of the state.
#' @param year the year to be selected.
#'
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @examples
#' \dontrun{
#' fars_map_state(1, 2014)
#' }
#'
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
