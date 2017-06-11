## ----scen 0--------------------------------------------------------------
library(badgecreatr)
badge_projectstatus("wip") # any of concept, wip, suspended, abandoned, active, inactive, unsupported

## ----scen 1--------------------------------------------------------------
minimal_badges(status = "concept", licence = "MIT",date = "2017-05-17")

## ----scen 2, eval=FALSE--------------------------------------------------
#  dynamic_badges_minimal(licence = "MIT", travisfile = TRUE, codecov = TRUE)

## ------------------------------------------------------------------------


## ---- eval=FALSE---------------------------------------------------------
#  # is not implemented yet.
#  place_badge_groups(
#      CI_status = c("travis", "rwin"),
#      versions = c("CRAN", "github"),
#      stats = c("downloads, gh_stars"))

