## ----scen 0--------------------------------------------------------------
library(badgecreatr)
projectstatusbadge("wip") # any of concept, wip, suspended, abandoned, active, inactive, unsupported

## ----scen 1--------------------------------------------------------------
minimal_badges("concept", "MIT")

## ----scen 2--------------------------------------------------------------
getwd()
dynamic_badges_minimal(licence = "MIT", travisfile = TRUE, codecov = TRUE, location = "../")

