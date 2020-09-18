# farsRP
Analysis of Fatality Analysis Reporting System (FARS) data

## Note
This project is an assignment of the Building R Packages courses.

## Objective
The package extracts information from Fatality Analysis Reporting data, creating summaries and graphs.

## Usage
Before using the functions, the FARS file should be installed in the working directory in the format accident_YEAR.csv.bz2, where YEAR is the corresponding year. The data can be found in the [NHTSA website](https://www.nhtsa.gov/Data/Fatality-Analysis-Reporting-System-(FARS)).
### Summarizing data from many years
To show the amount of fatalities in each month of one or many years the fars_summarize_years function can be used. It receives a vector containing the years that will be presented in the summary and returns a table with the amount of accidents each month.
```
# Amount of fatalities per month in the years of 2014 and 2015.
fars_summarize_years(c(2014, 2015))
```
### Plotting data for a specific state and year
The fars_map_state plots the location of the fatalities in the selected state map for a specific year.
```{r}
# The location of the fatalities in the state of code 1 and the year of 2014.
fars_map_state(1, 2014)
```

## Travis CI Badge
[![Build Status](https://travis-ci.com/RafaelSPeixoto/farsRP.svg?branch=master)](https://travis-ci.com/RafaelSPeixoto/farsRP)
