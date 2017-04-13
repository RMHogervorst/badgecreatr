## ----scen 0--------------------------------------------------------------
library(badgecreatr)
badge_projectstatus("wip") # any of concept, wip, suspended, abandoned, active, inactive, unsupported

## ----scen 1--------------------------------------------------------------
minimal_badges("concept", "MIT")

## ----scen 2, eval=FALSE--------------------------------------------------
#  ## doesn not work yet.
#  getwd()
#  dynamic_badges_minimal(licence = "MIT", travisfile = TRUE, codecov = TRUE, location = "../")

