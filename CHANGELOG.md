# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
R-version badge will be updated when you re-knit the readme.rmd to readme (thanks  Florian Privé @privefl)
vignette that explains badges
badge for r documentation


### Removed
dependency on stringr
### Deprecated 


### Fixed 
- when you rerun the command, no superflous lines will be added.  
- searches for licence badge and codecov badge didn't work. 
tx Stephanie Locke @steplocke for both these fixes.
- added location for all badges so that the badges can be used in other locations and not only in the top folder.
- Use only base R - remove dependency on stringr
- Use read.dcf() to read DESCRIPTION
- Simplify github access functions using git2r
Thanks Andrie de Vries @andrie for these huge improvements

### Security 

## [0.1.0] 2016-07-03
### Added
- r version badge
- changed the searchresults for badges into TRUE FALSE in stead of linenumber.
- existing badges will be recognized and not duplicated. 


### Removed
- nothing
### Deprecated 
- nothing
### Fixed 
- recognition of badges already placed. 

### Security 
- nothing

## [0.0.2] 2016-07-02
Currently creates badges for  Codecov, last change, travis, projectstatus
and licence. 
### Added
- Codecov badge
- last change
- travis
- projectstatus
- cran 
- packageversion

### Removed
-nothing
### Deprecated 
- nothing
### Fixed 
- nothing
### Security 
- nothing

## [0.0.1] - 2016-06-24
### Added
Started project with readme and several functions 
### Removed
- nothing
### Deprecated 
- nothing
