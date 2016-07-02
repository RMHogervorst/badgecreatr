[![Project Status: Active ? The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html) [![Last-changedate](https://img.shields.io/badge/last%20change-2016--07--02-yellowgreen.svg)](/commits/master) [![Build Status](https://travis-ci.org/RMHogervorst/badgecreatr.svg?branch=master)](https://travis-ci.org/RMHogervorst/badgecreatr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/badgecreatr)](http://cran.r-project.org/package=badgecreatr) [![packageversion](https://img.shields.io/badge/Package%20version-0.0.2-orange.svg?style=flat-square)](commits/master) [![codecov](https://codecov.io/gh/RMHogervorst/badgecreatr/branch/master/graph/badge.svg)](https://codecov.io/gh/RMHogervorst/badgecreatr)

<!-- README.md is generated from README.Rmd. Please edit that file -->
introduction
============

This package was inspired by the [badgerbadger](https://github.com/badges/badgerbadgerbadger) package that checks for badges of travis, code coverage open issues, dependencies and licenses. It would be nice to have a simple function that adds these things to a readme.rmd file in R. It will save you typing and searching for the exact markdown on the websites of travis, codecov, repostatus.org etc.

This package does now place the folowing badges /shields:

-   \[x\] repo status <http://www.repostatus.org/>
-   \[x\] travis shield
-   \[ \] code coverage
-   \[x\] licence

workflow
========

I like to use the following workflow:

-   start a new project in rstudio
-   after some functions are made start a package
-   start a github repo
-   create a readme.rmd
-   ( *this is where badgecreatr comes in*) create badges
-   continue with the project
-   submit to cran, bioconductor, ropensci etc

installation and use
====================

For now you will have to install using `devtools::install_github("rmhogervorst/badgecreatr")` Whenever you have created a readme, use badgeplacer()

content of `?badgeplacer`:

`badgeplacer(location = ".", status = "active", travis = TRUE,   codecov = FALSE, licence = "search", githubaccount = "search",   githubrepo = "search", branch = "master")`

The options are (bold is default):

-   location : folder where readme.rmd resides
-   status : one of: "concept", "wip", "suspended", "abandoned", *"active"*, "inactive", or "unsupported"
-   travis : logical *true* or false do you want to add this badge?
-   codecov : logical true or *false* do you want to add this badge?
-   licence : *"search"*, "gpl-2" , "MIT", etc
-   githubaccount : your githubname or *"search"* for it
-   githubrepo : your githubrepositoryname , or *"search"* for it
-   branch : *master*, develop, etc.

contact
=======

Want to help or have questions? contact me, fork me or send a pull request!
